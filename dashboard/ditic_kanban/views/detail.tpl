<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Tickets</title>
    <link rel="stylesheet" href="https://student.dei.uc.pt/~tmdcc/estilos.css"/>
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" integrity="sha512-dTfge/zgoMYpP7QbHy4gWMEGsbsdZeCXz7irItjcC3sPUFtf0kuFbDz/ixG7ArTxmDjLXDmezHubeNikyKGVyQ==" crossorigin="anonymous">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js">
    </script>

    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js" integrity="sha512-K1qjQ+NcF2TYO/eI3M6v8EiNYZfA95pQumfvcVrTHtwQVDG+aHRqLi/ETn2uB+1JqwYqVG3LIvdm9lj6imS/pQ==" crossorigin="anonymous"></script>

</head>

<body>
 % max_len = 30

    % action_result = get('action_result', '')
    % if action_result:
    <p>
        <strong>Action:</strong> <i>{{action_result}}</i>
    </p>
    % end
    <!-- THIS DEFINES THE MAXIMUM NUMBER OF TICKETS IN DONE-->
    % max = 5  
   <!-- NAVIGATION BAR -->
    <nav class="navbar navbar-default navigation">
        <div class="container-fluid">
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav">
                    <li><a href="/detail/main?o={{username_id}}">Home</a></li>
                    <li><a href="/detail/dir?o={{username_id}}">DIR</a></li>
                    <li><a href="/detail/dir-inbox?o={{username_id}}">DIR-INBOX</a></li>
                    <li><a href="/detail/statistic?o={{username_id}}">Statistics</a></li>
                    <li><a href="/detail/history?o={{username_id}}" >Archive</a></li>
                    <li><a href="/detail/new_ticket?o={{username_id}}">New Ticket</a></li>
                </ul>

                % username = get('username', '')
                % if username:
                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="#bells"><i class="fa fa-bell"></i></a></li>
                                                

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
   

    <section> 

        <div class="row">
            <div class="col-md-8 col-md-offset-2 list-table">
                <ul class="nav nav-tabs nomenav" role="tablist">
                    
                    <li role="presentation" class = "active historic-tab" >
                        <a href="#board1" aria-controls="board1" role="tab" data-toggle="tab">IN
                        
                        % status = 'new'
                        % if status in number_tickets_per_status and status in email_limit:
                            <br><span class="">({{number_tickets_per_status[status]}}/{{email_limit[status]}})</span></a>
                        % else:
                            <br><span class="">(0/{{email_limit[status]}})</span>
                        </a>
                        % end
                    </li>

                    <li role="presentation" class ="historic-tab" >
                        <a href="#board2" aria-controls="board2" role="tab" data-toggle="tab">ACTIVE
                        % status = 'open'
                        % if status in number_tickets_per_status and status in email_limit:
                            <br><span class="">({{number_tickets_per_status[status]}}/{{email_limit[status]}})</span></a>
                        % else:
                            <br><span class="">(0/{{email_limit[status]}})</span></a>
                        % end
                    </li>

                    <li role="presentation" class="historic-board">
                        <a href="#board3" aria-controls="board3" role="tab" data-toggle="tab">STALLED
                        
                        % status = 'stalled'
                        % if status in number_tickets_per_status:
                        <br><span class="">({{number_tickets_per_status[status]}})</span></a>
                        % else:
                            <br><span class="">(0)</span></a>
                        % end
                    </li>

                    <li role="presentation" class="historic-board">
                        <a href="#board4" aria-controls="board4" role="tab" data-toggle="tab">DONE

                        % status = 'resolved'
                        % if status in number_tickets_per_status:
                            <br><span class="">({{number_tickets_per_status[status]}}/{{max}})</span></a>
                        % else:
                            <br><span class="">(0/{{max}})</span></a>
                        % end
                        
                    </li>
                </ul>

                <div class="content">
                    <div class="tab-content">

                       <div role="tabpanel" class="tab-pane active" id="board1">
                            <table class="table">
                                <tr>
                                    % for status in ['new']: #, 'open', 'stalled', 'resolved']:
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
                                                        <br>Owner: {{ticket['owner']}}
                                                        <br>Creator: {{ticket['creator']}}
                                                        <br>Created: {{ticket['created']}}
                                                        <br>Last Update: {{ticket['lastupdated']}}
                                                    </div>
                                                </div>
                                            </td>

                                            % if ticket['kanban_actions']['forward']:  
                                            <td><a href="/ticket/{{ticket['id']}}/action/forward?o={{username_id}}&email={{email}}" type="button" class="btn btn-warning">ACTIVE</a></td> 
                                            % else:
                                            <td><a href="#" type="button" class="btn btn-warning">MAXIMUM ACHIEVED</a></td> 
                                            % end
                                            </tr>
                                            % end
                                        % end
                                    % end
                                <tr> 
                                <th colspan="5"> Time to execute: {{time_spent}} </th>
                                </tr>
                            </table>
                        </div>

                        <div role="tabpanel" class="tab-pane" id="board2">
                            <table class="table">
                                <tr>
                                    % for status in ['open']: #, 'open', 'stalled', 'resolved']:
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
                                                % if ticket['kanban_actions']['stalled']:
                                                    <a href="/ticket/{{ticket['id']}}/action/stalled?o={{username_id}}&email={{email}}">stall</a>
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
                                                        <br>Owner: {{ticket['owner']}}
                                                        <br>Creator: {{ticket['creator']}}
                                                        <br>Created: {{ticket['created']}}
                                                        <br>Last Update: {{ticket['lastupdated']}}
                                                    </div>
                                                    <a href="/done/{{ticket['id']}}/{{username_id}}?o={{username_id}}&email={{email}}" type="button" class="btn btn-warning">RESOLVE
                                                    </a>
                                                    
                                                    <button type="button" class="btn btn-warning" data-toggle="modal" data-target="#childticket" data-whatever="@mdo">CHILD</button>
                                                </div>
                                            </td>

                                            <div class="modal fade" id="childticket" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
                                                <div class="modal-dialog" role="document">
                                                    <div class="modal-content">

                                                        <div class="modal-header">
                                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                                            <h4 class="modal-title" id="childticket">Child Ticket</h4>
                                                        </div>

                                                        <div class="modal-body">
                                                            <form class = "input-group" action="/ticket/child?o={{username_id}}" method="post">
                                                                <div class="input-group">
                                                                    <span class="input-group-addon yellow1 alinhar" id="basic-addon1">Ticket Subject</span>
                                                                    <input type="text" class="form-control" placeholder="Ticket Subject" aria-describedby="basic-addon1" name= "subject">
                                                                </div>
                                                                <br>
                                                                <div class="input-group">
                                                                    <span class="input-group-addon yellow1" id="basic-addon1">Ticket Description</span>
                                                                    <input type="text" class="form-control" placeholder="Ticket Description" aria-describedby="basic-addon1" name ="description">
                                                                </div>
                                                                <div class="row">
                                                                    <div class="col-md-0 col-md-offset-9 btn">
                                                                        <div class="btn-group" role="group">
                                                                            <input type="submit" value="Create Ticket">
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </form>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            </tr>
                                            % end
                                        % end
                                    % end
                                <tr> 
                                <th colspan="5"> Time to execute: {{time_spent}} </th>
                                </tr>
                            </table>
                        </div>


                        <div role="tabpanel" class="tab-pane" id="board3">
                            <table class="table">
                                <tr>
                                    % for status in ['stalled']: #, 'open', 'stalled', 'resolved']:
                                    %   if status not in tickets.keys():
                                    %       continue
                                    %   end

                                        % for priority in sorted(tickets[status], reverse=True):
                                            % for ticket in tickets[status][priority]:
                                                <td valign="top">
                                                    <strong>
                                                        % if ticket['kanban_actions']['decrease_priority']:
                                                        <a href="/ticket/{{ticket['id']}}/action/decrease_priority?o={{username_id}}&email={{email}}">&#8595</a>
                                                        % end
                                                        {{priority}}
                                                        
                                                        % if ticket['kanban_actions']['increase_priority']:
                                                        <a href="/ticket/{{ticket['id']}}/action/increase_priority?o={{username_id}}&email={{email}}">&#8593</a>
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
                                                            <br>Owner: {{ticket['owner']}}
                                                            <br>Creator: {{ticket['creator']}}
                                                            <br>Created: {{ticket['created']}}
                                                            <br>Last Update: {{ticket['lastupdated']}}
                                                        </div>
                                                    </div>
                                                </td>

                                                <td><a href="/ticket/{{ticket['id']}}/action/back?o={{username_id}}&email={{email}}" type="button" class="btn btn-warning">RETURN TO IN</a></td> 
                                            </tr>    
                                            % end
                                        % end
                                    % end
                                <tr> 
                                <th colspan="5"> Time to execute: {{time_spent}} </th>
                                </tr>
                            </table>    
                        </div>
                        
                        <div role="tabpanel" class="tab-pane" id="board4">
                            <table class="table">
                
                                <tr>
                                    % counter = 0
                                    % for status in ['resolved']: #, 'open', 'stalled', 'resolved']:
                                    %   if status not in tickets.keys():
                                    %       continue
                                    %   end
                       
                                        % for priority in sorted(tickets[status], reverse=True):
                                            % for ticket in tickets[status][priority]:
                                                % if (counter < max):
                                                    <td valign="top">
                                                        <strong>
                                                        
                                                         <a href="/ticket/{{ticket['id']}}/action/back?o={{username_id}}&email={{email}}">&#8592</a>
                                                        
                                                        {{priority}}
                                                        
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
                                                                <br>Owner: {{ticket['owner']}}
                                                                <br>Creator: {{ticket['creator']}}
                                                                <br>Created: {{ticket['created']}}
                                                                <br>Last Update: {{ticket['lastupdated']}}
                                                            </div>
                                                        </div>
                                                    </td>
                                                % counter +=1
                                                % end
                                                <td><a href="/archive/{{ticket['id']}}/archive?o={{username_id}}&email={{email}}" type="button" class="btn btn-warning">ARCHIVE </a></td> 
                                                </tr>
                                            %end   
                                        % end
                                    % end 
                                <tr> 
                                <th colspan="5"> Time to execute: {{time_spent}} </th>
                                </tr>
                            </table>
                        </div>
                    </div>
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




