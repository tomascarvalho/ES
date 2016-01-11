# -*- coding: utf-8 -*-
#
# By Pedro Vapi @2015
# This module is responsible for web routing. This is the main web server.
#
from time import time
from datetime import date
import os
import rt_summary
import statistics
global emailGlobal
global ticket_id_comment

from bottle import get
from bottle import post
from bottle import template
from bottle import request
from bottle import run
from bottle import redirect
from bottle import route
from bottle import static_file

from ditic_kanban.rt_summary import get_summary_info
from ditic_kanban.config import DITICConfig
from ditic_kanban.auth import UserAuth
from ditic_kanban.tools import user_tickets_details
from ditic_kanban.tools import ticket_actions
from ditic_kanban.tools import user_closed_tickets
from ditic_kanban.tools import create_ticket
from ditic_kanban.tools import create_child_ticket
from ditic_kanban.tools import search_tickets
from ditic_kanban.tools import get_urgent_tickets
from ditic_kanban.rt_api import RTApi
from ditic_kanban.statistics import get_date
from ditic_kanban.statistics import get_statistics
from ditic_kanban.rt_api import modify_ticket


# My first global variable...
user_auth = UserAuth()

# Only used by the URGENT tickets search
my_config = DITICConfig()
system = my_config.get_system()
rt_object = RTApi(system['server'], system['username'], system['password'])

# This part is necessary in order to get access to sound files
# Static dir is in the parent directory
STATIC_PATH = os.path.abspath(os.path.join(os.path.dirname(__file__), "../static"))
print STATIC_PATH


def create_default_result():
    # Default header configuration
    result = {
        'title': 'Still testing...'
    }

    # Summary information
    result.update({'summary': get_summary_info()})

    # Mapping email do uer alias
    config = DITICConfig()
    result.update({'alias': config.get_email_to_user()})

    return result


@get('/')
def get_root():
	start_time = time()
	
	rt_summary.generate_summary_file()
	rt_summary.get_summary_info()
	statistics.stats_update_json_file()

	result = create_default_result()
	# Removed to be a display at the TV
	#if request.query.o == '' or not user_auth.check_id(request.query.o):
	#    result.update({'message': ''})
	#    return template('auth', result)
	#result.update({'username': user_auth.get_email_from_id(request.query.o)})
	result.update({'username_id': request.query.o})
	today = date.today().isoformat()
	result.update({'statistics': get_statistics(get_date(30, today), today)})

	# Is there any URGENT ticket?
	result.update({'urgent': get_urgent_tickets(rt_object)})

	result.update({'time_spent': '%0.2f seconds' % (time() - start_time)})
	
	return template('entrance_summary', result)

@get('/display/<ticket_id>')
def display(ticket_id):
	result = create_default_result()
	aux = rt_object.get_data_from_rest('ticket/'+ticket_id+'/show', '')

	
	result.update({'id': aux[2]})
	result.update({'Queue':aux[3]})
	result.update({'Owner':aux[4]})
	result.update({'Creator':aux[5]})
	result.update({'Subject':aux[6]})
	result.update({'Status':aux[7]})
	result.update({'Priority':aux[8]})
	result.update({'InitialPriority':aux[9]})
	result.update({'FinalPriority':aux[10]})
	result.update({'Requestors':aux[11]})
	result.update({'Cc':aux[12]})
	result.update({'AdminCc':aux[13]})
	result.update({'Created':aux[14]})
	result.update({'Starts':aux[15]})
	result.update({'Started':aux[16]})
	result.update({'Due':aux[17]})
	result.update({'Resolved':aux[18]})
	result.update({'Told':aux[19]})
	result.update({'LastUpdated':aux[20]})
	result.update({'TimeEstimated':aux[21]})
	result.update({'TimeWorked':aux[22]})
	result.update({'TimeLeft':aux[23]})
	result.update({'CF.{IS - Informatica e Sistemas}': aux[24]})
	result.update({'CF.{Servico}':aux[25]})
	
	return template('description', result)

@get('ticket/<ticket_id>/show')
def display2(ticket_id):
	redirect('/')
	return

@get('/done/<ticket_id>/<username_id>')
def justificacao(ticket_id,username_id):
	result = create_default_result()
	result.update({'ticket_id': ticket_id})

	if request.query.o == '' or not user_auth.check_id(request.query.o):
		result.update({'message': ''})
		return template('auth', result)

	result.update({'username': user_auth.get_email_from_id(request.query.o)})
	result.update({'username_id': request.query.o})

	return template('done', result)
			
@get('/archive/<ticket_id>/<action>')
def archive_ticket(ticket_id,action):
	start_time = time()

	result = create_default_result()
	if request.query.o == '' or not user_auth.check_id(request.query.o):
		result.update({'message': ''})
		return template('auth', result)

	# Apply the action to the ticket
	result.update(ticket_actions(
		user_auth.get_rt_object_from_email(
		    user_auth.get_email_from_id(request.query.o)
		),
		ticket_id,
		action,
		request.query.email, user_auth.get_email_from_id(request.query.o)
	))

	# Update table for this user
	result.update(user_tickets_details(
		user_auth.get_rt_object_from_email(
		    user_auth.get_email_from_id(request.query.o)
		), request.query.email))

	result.update({'username': user_auth.get_email_from_id(request.query.o)})
	result.update({'email': request.query.email})
	result.update({'username_id': request.query.o})

	# Is there any URGENT ticket?
	result.update({'urgent': get_urgent_tickets(rt_object)})

	result.update({'time_spent': '%0.2f seconds' % (time() - start_time)})


	modify_ticket(
			rt_object,
			ticket_id,
			{
				'status': 'archived',
				
			}
		)

	return template('history', result)

@post('/ticket/<ticket_id>/<username_id>/<username>/comment')
def justificacao_2(ticket_id,username_id,username):
	comment_ticket = {
		'id': ticket_id,
		'Action': "comment",
		'Text': request.forms.get('justificacao'),
	}
	content = ''
	for key in comment_ticket:
		content += '{0}: {1}\n'.format(key,comment_ticket[key])
	query = {
		'content':content
	}
	rt_object.get_data_from_rest('/ticket/'+ticket_id+'/comment', query)
	
	modify_ticket(
			rt_object,
			ticket_id,
			{
				'status': 'resolved',
				
			}
		)

	redirect("/detail/"+username+"?o="+username_id)

@post('/auth')
def auth():
    result = create_default_result()
    result.update({'username': request.forms.get('username'), 'password': request.forms.get('password')})
    if request.forms.get('username') and request.forms.get('password'):
        try:
            if user_auth.check_password(request.forms.get('username'), request.forms.get('password')):
                redirect('/detail/main?o=%s' % user_auth.get_email_id(result.get('username')))
            else:
                result.update({'message': 'Password incorrect'})
                return template('auth', result)
        except ValueError as e:
            result.update({'message': str(e)})
            return template('auth', result)
    else:
        result.update({'message': 'Mandatory fields'})
        return template('auth', result)


@get('/detail/<email>')
def email_detail(email):
	start_time = time()
	global emailGlobal
	emailGlobal=email
	result = create_default_result()
	if request.query.o == '' or not user_auth.check_id(request.query.o):
		result.update({'message': ''})
		return template('auth', result)

	result.update({'username': user_auth.get_email_from_id(request.query.o)})
	result.update({'email': email})
	result.update({'username_id': request.query.o})
	
	result.update(user_tickets_details(
		user_auth.get_rt_object_from_email(
		    user_auth.get_email_from_id(request.query.o)
		), email))

	# Is there any URGENT ticket?
	result.update({'urgent': get_urgent_tickets(rt_object)})

	today = date.today().isoformat()
	result.update({'time_spent': '%0.2f seconds' % (time() - start_time)})
	result.update({'statistics': get_statistics(get_date(30, today), today)})

	if email == 'dir' or email == 'dir-inbox':
		return template('dir', result)
	elif email == 'history':
		return template('history', result)
	elif email == 'main' or email == 'unknown':
		return template('entrance_summary', result)
	elif email == 'new_ticket':
		return template('newticket', result)
	elif email == 'statistic':
		return template('statistic', result)
	else:
		return template('detail', result)


@get('/closed/<email>')
def email_detail(email):
	start_time = time()

	result = create_default_result()
	if request.query.o == '' or not user_auth.check_id(request.query.o):
		result.update({'message': ''})
		return template('auth', result)

	result.update({'username': user_auth.get_email_from_id(request.query.o)})
	result.update({'email': email})
	result.update({'username_id': request.query.o})

	result.update(user_closed_tickets(
		user_auth.get_rt_object_from_email(
		    user_auth.get_email_from_id(request.query.o)
		), email))

	# Is there any URGENT ticket?
	result.update({'urgent': get_urgent_tickets(rt_object)})

	result.update({'time_spent': '%0.2f seconds' % (time() - start_time)})

	return template('ticket_list', result)


@post('/search')
def search():
	start_time = time()

	result = create_default_result()
	if request.query.o == '' or not user_auth.check_id(request.query.o):
		result.update({'message': ''})
		return template('auth', result)

	if not request.forms.get('search'):
		redirect('/?o=%s' % request.query.o)
	search = request.forms.get('search')

	result.update({'username': user_auth.get_email_from_id(request.query.o)})
	result.update({'email': search})
	result.update({'username_id': request.query.o})

	result.update(search_tickets(
		user_auth.get_rt_object_from_email(
		    user_auth.get_email_from_id(request.query.o)
		), search))

	# Is there any URGENT ticket?
	result.update({'urgent': get_urgent_tickets(rt_object)})

	result.update({'time_spent': '%0.2f seconds' % (time() - start_time)})

	return template('new_search', result)


@get('/ticket/<ticket_id>/action/<action>')
def ticket_action(ticket_id,action):
	global emailGlobal
	ticket_action2(ticket_id,action)
	rt_summary.generate_summary_file()
	rt_summary.get_summary_info()
	statistics.stats_update_json_file()
	redirect("/detail/"+emailGlobal+"?o="+request.query.o)


def ticket_action2(ticket_id, action):
	
	start_time = time()

	result = create_default_result()
	if request.query.o == '' or not user_auth.check_id(request.query.o):
		result.update({'message': ''})
		return template('auth', result)

	# Apply the action to the ticket
	result.update(ticket_actions(
		user_auth.get_rt_object_from_email(
		    user_auth.get_email_from_id(request.query.o)
		),
		ticket_id,
		action,
		request.query.email, user_auth.get_email_from_id(request.query.o)
	))

	# Update table for this user
	result.update(user_tickets_details(
		user_auth.get_rt_object_from_email(
		    user_auth.get_email_from_id(request.query.o)
		), request.query.email))

	result.update({'username': user_auth.get_email_from_id(request.query.o)})
	result.update({'email': request.query.email})
	result.update({'username_id': request.query.o})

	# Is there any URGENT ticket?
	result.update({'urgent': get_urgent_tickets(rt_object)})

	result.update({'time_spent': '%0.2f seconds' % (time() - start_time)})

	#update all

	if request.query.email == 'dir' or request.query.email == 'dir-inbox' or request.query.email == 'unknown':
		return template('ticket_list', result)

	elif request.query.email == 'history':
		return template('history', result)

	else:
		return template('detail', result)

@post('/ticket/new')
def create():
  result =create_default_result();

  if request.query.o == '' or not user_auth.check_id(request.query.o):
    result.update({'message': ''})
    return template('auth', result)

  if not request.forms.get('subject'):
    redirect('/?o=%s' % request.query.o)
  if not request.forms.get('description'):
    redirect('/?o=%s' % request.query.o)

  create_ticket(user_auth.get_rt_object_from_email(user_auth.get_email_from_id(request.query.o)),request.forms.get('subject'),request.forms.get('description'))
  
  redirect('/?o=%s' % request.query.o)

@post('/ticket/child')
def create():
  result =create_default_result();

  if request.query.o == '' or not user_auth.check_id(request.query.o):
    result.update({'message': ''})
    return template('auth', result)

  if not request.forms.get('subject'):
    redirect('/?o=%s' % request.query.o)
  if not request.forms.get('description'):
    redirect('/?o=%s' % request.query.o)

  create_child_ticket(user_auth.get_rt_object_from_email(user_auth.get_email_from_id(request.query.o)),request.forms.get('subject'),request.forms.get('description'))
  redirect('/?o=%s' % request.query.o)

@route("/static/<filepath:path>", name="static")
def static(filepath):
    return static_file(filepath, root=STATIC_PATH)


def start_server():
    run(server='paste', host='0.0.0.0', debug=True)

if __name__ == '__main__':
    start_server()
