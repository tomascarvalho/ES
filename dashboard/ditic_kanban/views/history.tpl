<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Archive</title>
    <link rel="stylesheet" href="https://student.dei.uc.pt/~tmdcc/estilos.css"/>
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" integrity="sha512-dTfge/zgoMYpP7QbHy4gWMEGsbsdZeCXz7irItjcC3sPUFtf0kuFbDz/ixG7ArTxmDjLXDmezHubeNikyKGVyQ==" crossorigin="anonymous">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js">
    </script>

    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js" integrity="sha512-K1qjQ+NcF2TYO/eI3M6v8EiNYZfA95pQumfvcVrTHtwQVDG+aHRqLi/ETn2uB+1JqwYqVG3LIvdm9lj6imS/pQ==" crossorigin="anonymous"></script>

</head>

<body>
    
    % action_result = get('action_result', '')
    % if action_result:
    <p>
        <strong>Action:</strong> <i>{{action_result}}</i>
    </p>
    % end

    <p>
        % ticket_id = get('ticket_id', '')
        % username_id = get('username_id','')
    </p>

   <!-- NAVIGATION BAR -->
    <nav class="navbar navbar-default navigation">
        <div class="container-fluid">
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav">
                    <li><a href="/detail/main?o={{username_id}}">Home</a></li>
                    
                    <li><a href="/detail/dir?o={{username_id}}">DIR</a></li>
 
                    <li><a href="/detail/dir-inbox?o={{username_id}}">DIR-INBOX</a></li>
                   
                    <li><a href="/detail/statistic?o={{username_id}}">Statistics</a></li>
                    <li class="active"><a href="/detail/history?o={{username_id}}" >Archive</a></li>
                    <li><a href="/detail/new_ticket?o={{username_id}}">New Ticket</a></li>
                </ul>

                % username = get('username', '')
                % if username:
                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="#campainha"><i class="fa fa-bell"></i></a></li>
                        <li class="dropdown">
                        
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">{{username}} <span class="caret"></span></a>
                            <ul class="dropdown-menu">
                                
                                
                                <li><a href="/detail/{{username}}?o={{username_id}}">MY TICKETS</a></li>
                                <li><a href="/">Log Out</a></li>
                            </ul>
                        </li>
                    </ul>
                % end
            </div>
        </div>
    </nav>
    % max_len = 30

    <section> 

        <div class="row">
            <div class="col-md-8 col-md-offset-2 list-table">
                <ul class="nav nav-tabs nomenav" role="tablist">
                    
                    <li role="presentation" class = "active historic-tab" >
                        <a href="#board1" aria-controls="board1" role="tab" data-toggle="tab">ARCHIVE
                        
                        % status = 'archived'
                        % if status in number_tickets_per_status:
                            <br><span class="">({{number_tickets_per_status[status]}})</span></a>
                        % else:
                            <br><span class="">(0)</span>
                        </a>
                        % end
                    </li>
                </ul>
                        
                        <div role="tabpanel" class="tab-pane" id="board1">
                            <table class="table">
                
                                <tr>
                                   
                                    % for status in ['archived']: #, 'open', 'stalled', 'resolved']:
                                    %   if status not in tickets.keys():
                                    %       continue
                                    %   end
                       
                                        % for priority in sorted(tickets[status], reverse=True):
                                            % for ticket in tickets[status][priority]:
                                                <td valign="top">
                                                    <strong>
                                                    % if ticket['kanban_actions']['back']:
                                                    <a href="/ticket/{{ticket['id']}}/action/back?o={{username_id}}&email={{email}}">&#8592</a>
                                                    % end
                                                
                                                    % if ticket['kanban_actions']['decrease_priority']:
                                                    <a href="/ticket/{{ticket['id']}}/action/decrease_priority?o={{username_id}}&email={{email}}">&#8595</a>
                                                    % end

                                                    {{priority}}
                                                    
                                                    </strong>
                                                    % if ticket['kanban_actions']['increase_priority']:
                                                    <strong><a href="/ticket/{{ticket['id']}}/action/increase_priority?o={{username_id}}&email={{email}}">&#8593</a>
                                                    % end
                                                    </strong>
                                                </td>
                                                <td>{{ticket['id']}}</td>
                                                
                                                <td> 
                                                    <button class="btn btn-default" type="button" data-toggle="collapse" data-target="#{{ticket['id']}}" aria-expanded="false" aria-controls="collapseExample">
                                                    % subject = ticket['subject']
                                                    % if len(ticket['subject']) > max_len:
                                                    %   subject = ticket['subject'][:max_len]+'...'
                                                    % end
                                                    {{subject}}
                                                    </button>
                                                    <div class="collapse" id="{{ticket['id']}}">
                                                        <div class="well">
                                                            {{ticket['description']}}
                                                            <br>Created: {{ticket['created']}}
                                                            <br>Last Update: {{ticket['lastupdated']}}
                                                        </div>
                                                    </div>
                                                </td>
                                         
                                    
                                </tr>
                                % end
                                % end
                          
                            </table>
                        </div>
            </div>
        </div>
    </section>

</body>


<script>
    $('#myTabs a').click(function (e) {
        e.preventDefault()
        $(this).tab('show')
    })

    $(".checkbox").change(function() {
        $(this).parent().parent().toggleClass("highlight");
    });

</script>



</html>



<p>
    Time to execute: {{time_spent}}
</p>
