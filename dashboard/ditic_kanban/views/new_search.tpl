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

    % max_len = 80

   <!-- NAVIGATION BAR -->
    <nav class="navbar navbar-default navigation">
        <div class="container-fluid">
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav">
                    <li><a href="/detail/main?o={{username_id}}">Home</a></li>
                    % if email =='dir':
                    <li class = "active"><a href="/detail/dir?o={{username_id}}">DIR</a></li>
                    % else:
                    <li><a href="/detail/dir?o={{username_id}}">DIR</a></li>
                    % end
                    % if email != 'dir':
                    <li class= "active"><a href="/detail/dir-inbox?o={{username_id}}">DIR-INBOX</a></li>
                    % else:
                    
                    <li><a href="/detail/dir-inbox?o={{username_id}}">DIR-INBOX</a></li>
                    % end
                    <li><a href="/detail/statistic?o={{username_id}}">Statistics</a></li>
                    <li><a href="/detail/history?o={{username_id}}" >Archive</a></li>
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
  

    <section> 

        <div class="row">
            <div class="col-md-8 col-md-offset-2 list-table">

                <ul class="nav nav-tabs" role="tablist">
                    <li role="presentation" class="active dir-tab"><a href="#home" aria-controls="kaban-board" role="tab" data-toggle="tab">
                        DIR - SEARCH
                        <br>(<strong><i>{{number_tickets}}</i></strong>) 
                    </li></a>
                </ul>

                <div class="content">
                    <div class="tab-content">
                        <div role="tabpanel" class="tab-pane active" id="kaban-board">
                            <table class="table">
                                % for priority in sorted(tickets, reverse=True):
                                <tr>
                                    % for ticket in sorted(tickets[priority], reverse=True):
                                    <td valign="top">
                                        
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

                                    <td> <input type="checkbox" class="checkbox" aria-label="..."></td>

                                </tr>
                                % end
                            </table>

                            <div class="row">
                                <div class="col-md-2 col-md-offset-10 btn">
                                    <div class="btn-group" role="group" aria-label="...">
                                        <button type="button" class="btn btn-warning">IN-BOX</button>
                                    </div>
                                </div>
                            </div>
                            <p>
                                <strong>Searching for (last 90 days): </strong><i>{{email}}</i><br>
                            </p>

                            <form action="/search?o={{get('username_id', '')}}" method="post">
                                Search: <input name="search" type="search">
                            </form>

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
