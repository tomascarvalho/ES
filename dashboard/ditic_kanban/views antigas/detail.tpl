<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>SITE_ES</title>
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

<p>
    <strong>Detail of email:</strong> {{email}} (<a href="/closed/{{email}}?o={{username_id}}">show closed tickets</a>)
</p>

% action_result = get('action_result', '')
% if action_result:
<p>
    <strong>Action:</strong> <i>{{action_result}}</i>
</p>
% end

    <body>

    <!-- NAVIGATION BAR -->
    <nav class="navbar navbar-default navigation">
        <div class="container-fluid">
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav">
                    <li><a href="main.html">Home</a></li>
                    <li ><a href="dir.html">DIR</a></li>    
                    <li><a href="statistic.html">Statistics</a></li>
                    <li><a href="historic.html">Historic</a></li>
                </ul>

                <ul class="nav navbar-nav navbar-right">
                    <li><a href="#campainha"><i class="fa fa-bell"></i></a></li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false" >#Nome User <span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a href="newticket.html">New Ticket</a></li>
                            <li><a href="tickets.html">Tickets</a></li>
                            <li><a href="#">Log Out</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <section> 

        <div class="row">
            <div class="col-md-8 col-md-offset-2 list-table">
                <ul class="nav nav-tabs nomenav" role="tablist">
                    
                    <li role="presentation" class = "active historic-tab" >
                        <a href="#board2" aria-controls="board2" role="tab" data-toggle="tab">IN
                        
                        % status = 'new'
                        % if status in number_tickets_per_status:
                            <br><span class="">{{number_tickets_per_status[status]}}</span></a>
                        % end
                        % if status in email_limit:
                            (max: {{email_limit[status]}})
                        % end
                    </li>
                    <li role="presentation" >
                        <a href="#board3" aria-controls="board3" role="tab" data-toggle="tab">ACTIVE
                        <br><span class="">(4/20)</span></a>
                    </li>
                    <li role="presentation" >
                        <a href="#board4" aria-controls="board4" role="tab" data-toggle="tab">DONE
                        <br><span class="">(15)</span></a>
                    </li>
                </ul>

                <div class="content">
                    <div class="tab-content">
                        

                        <div role="tabpanel" class="tab-pane active" id="board2">
                            <table class="table">
                                <tr>
                                    <td class="primeiro">Ticket 1</td>
                                    <td class="primeiro"> <button class="btn btn-default" type="button" data-toggle="collapse" data-target="#ticket8" aria-expanded="false" aria-controls="collapseExample">
                                        Titulo/Assunto do Ticket
                                    </button>
                                    <div class="collapse" id="ticket8">
                                        <div class="well">
                                            Descrição do ticket
                                        </div>
                                    </div></td>
                                    <td class="primeiro"> <input type="checkbox" class="checkbox" aria-label="..."></td>
                                </tr>
                                
                            </table>

                            <div class="row">
                                <div class="col-md-2 col-md-offset-10 btn">
                                    <div class="btn-group" role="group" aria-label="..."> 
                                        <button type="button" class="btn btn-warning">ACTIVE</button>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div role="tabpanel" class="tab-pane" id="board3">
                            <table class="table">
                                <tr>
                                    <td class="primeiro">Ticket 1</td>
                                    <td class="primeiro"> <button class="btn btn-default" type="button" data-toggle="collapse" data-target="#ticket15" aria-expanded="false" aria-controls="collapseExample">
                                        Titulo/Assunto do Ticket
                                    </button>
                                    <div class="collapse" id="ticket15">
                                        <div class="well"> 
                                            Descrição do ticket
                                        </div>
                                        <button type="button" class="btn btn-warning" data-toggle="modal" data-target="#closeticket" data-whatever="@mdo">CLOSE</button>
                                        <button type="button" class="btn btn-warning" data-toggle="modal" data-target="#childticket" data-whatever="@mdo">CHILD</button>
                                        <div class="modal fade" id="closeticket" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
                                            <div class="modal-dialog" role="document">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                                        <h4 class="modal-title" id="closeticket">Fechar Ticket</h4>
                                                    </div>
                                                    <div class="modal-body">
                                                        <form>
                                                            <div class="form-group">
                                                                <label for="message-text" class="control-label">Comentário:</label>
                                                                <textarea class="form-control" id="message-text"></textarea>
                                                            </div>
                                                        </form>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-warning">CLOSE TICKET</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="modal fade" id="childticket" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
                                            <div class="modal-dialog" role="document">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                                        <h4 class="modal-title" id="childticket">Child Ticket</h4>
                                                    </div>
                                                    <div class="modal-body">
                                                        <form>
                                                            <div class="form-group">
                                                                <label for="recipient-name" class="control-label">Assunto:</label>
                                                                <input type="text" class="form-control" id="recipient-name">
                                                            </div>
                                                        </form>
                                                        <div class="modal-body">
                                                            <form>
                                                                <div class="form-group">
                                                                    <label for="message-text" class="control-label">Comentário:</label>
                                                                    <textarea class="form-control" id="message-text"></textarea>
                                                                </div>
                                                            </form>
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-warning">CHILD</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div></td>
                                </tr>
                            </table>

                            <div class="row">
                                <div class="col-md-2 col-md-offset-10 btn">
                                    <div class="btn-group" role="group" aria-label="..."> 
                                        <button type="button" class="btn btn-warning">DONE</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div role="tabpanel" class="tab-pane" id="board4">
                            <table class="table">
                                <tr>
                                    <td class="primeiro">Ticket 1</td>
                                    <td class="primeiro"> <button class="btn btn-default" type="button" data-toggle="collapse" data-target="#ticket22" aria-expanded="false" aria-controls="collapseExample">
                                        Titulo/Assunto do Ticket
                                    </button>
                                    <div class="collapse" id="ticket22">
                                        <div class="well">
                                            Descrição do ticket
                                        </div>
                                    </div></td>
                                </tr>
                                
                            </table>
                        </div>

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



<table border="1" width="100%">
    <tr>
        <td align="center">
            <strong>IN</strong><br>
            % status = 'new'
            % if status in number_tickets_per_status:
                <strong>{{number_tickets_per_status[status]}}</strong>
            % end
            % if status in email_limit:
                (max: {{email_limit[status]}})
            % end
        </td>
        <td align="center">
            <strong>ACTIVE</strong><br>
            % status = 'open'
            % if status in number_tickets_per_status:
                <strong>{{number_tickets_per_status[status]}}</strong>
            % end
            % if status in email_limit:
                (max: {{email_limit[status]}})
            % end
        </td>
        <td align="center"><strong>STALLED</strong></td>
        <td align="center">
            <strong>DONE</strong><br>
            % status = 'resolved'
            % if status in number_tickets_per_status:
                <strong>{{number_tickets_per_status[status]}}</strong>
            % end
            % if status in email_limit:
                (max: {{email_limit[status]}})
            % end
        </td>
    </tr>
    <tr>
        % for status in ['new', 'open', 'stalled', 'resolved']:
        %   if status not in tickets.keys():
        <td></td>
        %       continue
        %   end
        <td valign="top">
        %   for priority in sorted(tickets[status], reverse=True):
            {{priority}}<br>
            % for ticket in tickets[status][priority]:
            &nbsp;&nbsp;
            % if ticket['kanban_actions']['back']:
            <a href="/ticket/{{ticket['id']}}/action/back?o={{username_id}}&email={{email}}">&lt;</a>
            % end
            % if ticket['kanban_actions']['interrupted']:
            <a href="/ticket/{{ticket['id']}}/action/interrupted?o={{username_id}}&email={{email}}">/</a>
            % end
            % if ticket['kanban_actions']['increase_priority']:
            <a href="/ticket/{{ticket['id']}}/action/increase_priority?o={{username_id}}&email={{email}}">^</a>
            % end
            <a title="#{{ticket['id']}}

Owner: {{ticket['owner']}}
Status: {{ticket['status']}}
TimeWorked: {{ticket['timeworked']}}

Requestor: {{ticket['requestors']}}
Subject: {{ticket['subject']}}" href="http://localhost:8080/Ticket/Display.html?id={{username_id}}&email={{email}}">
                {{ticket['id']}}
                % subject = ticket['subject']
                % if len(ticket['subject']) > max_len:
                %   subject = ticket['subject'][:max_len]+'...'
                % end
                {{subject}}
            </a>
            % if ticket['kanban_actions']['decrease_priority']:
            <a href="/ticket/{{ticket['id']}}/action/decrease_priority?o={{username_id}}&email={{email}}">v</a>
            % end
            % if ticket['kanban_actions']['stalled']:
            <a href="/ticket/{{ticket['id']}}/action/stalled?o={{username_id}}&email={{email}}">\</a>
            % end
            % if ticket['kanban_actions']['forward']:
            <a href="/ticket/{{ticket['id']}}/action/forward?o={{username_id}}&email={{email}}">&gt;</a>
            % end
            % if ticket['kanban_actions']['done']:
            <a href="/done/{{ticket['id']}}?o={{username_id}}&email={{email}}">done</a>
            % end
            <br>
            % end
        %   end
        </td>
        % end
    </tr>
</table>

<p>
    Time to execute: {{time_spent}}
</p>
