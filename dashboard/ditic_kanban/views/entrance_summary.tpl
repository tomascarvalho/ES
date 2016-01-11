<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Home</title>
    <link rel="stylesheet" href="https://student.dei.uc.pt/~tmdcc/estilos.css"/>
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" integrity="sha512-dTfge/zgoMYpP7QbHy4gWMEGsbsdZeCXz7irItjcC3sPUFtf0kuFbDz/ixG7ArTxmDjLXDmezHubeNikyKGVyQ==" crossorigin="anonymous">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js">
    </script>

    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js" integrity="sha512-K1qjQ+NcF2TYO/eI3M6v8EiNYZfA95pQumfvcVrTHtwQVDG+aHRqLi/ETn2uB+1JqwYqVG3LIvdm9lj6imS/pQ==" crossorigin="anonymous"></script>

</head>

<body>
    

    <p>
        % username = get('username', '')
    </p>

    <!-- NAVIGATION BAR -->
    <nav class="navbar navbar-default navigation">
        <div class="container-fluid">
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav">
                    <li class = "active"><a href="/detail/main?o={{username_id}}">Home</a></li>                   
                    <li><a href="/detail/dir?o={{username_id}}">DIR</a></li>
                    <li><a href="/detail/dir-inbox?o={{username_id}}">DIR-INBOX</a></li>          
                    <li><a href="/detail/statistic?o={{username_id}}">Statistics</a></li>
                    <li><a href="/detail/history?o={{username_id}}" >Archive</a></li>
                    <li><a href="/detail/new_ticket?o={{username_id}}">New Ticket</a></li>
                </ul>

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
    
% result = "['Date', 'Created', 'Resolved', 'Still open'],\n"
% for day in sorted(statistics):
%   if statistics[day]:
%       result += '''["%s", %s, %s, %s],\n''' % (day,
%                                              statistics[day]["created_tickets"],
%                                              statistics[day]['team']['resolved'],
%                                              statistics[day]['team']['open'])
%   else:
%       result += '["%s", 0, 0, 0],\n' % day
%   end
% end

% graph_script = """
    <script type="text/javascript"
          src="https://www.google.com/jsapi?autoload={
            'modules':[{
              'name':'visualization',
              'version':'1',
              'packages':['corechart']
            }]
          }"></script>

    <script type="text/javascript">
      google.setOnLoadCallback(drawChart);

      function drawChart() {
        var data = google.visualization.arrayToDataTable([
%s
        ]);

        var options = {
          title: 'Número de tickets',
          curveType: 'function',
          legend: { position: 'bottom' },
        };

        var chart = new google.visualization.LineChart(document.getElementById('performance'));

        chart.draw(data, options);
      }
    </script>
""" % result

% result = "['Date', 'Mean Time to Resolve', 'Time worked'],\n"
% for day in sorted(statistics):
%   if statistics[day]:
%       result += '''["%s", %s, %s],\n''' % (day,
%                                      statistics[day]['team']['mean_time_to_resolve']/60,
%                                      statistics[day]['team']['time_worked']/60)
%   else:
%       result += '["%s", 0, 0],\n' % day
%   end
% end
% graph_script += """
 <script type="text/javascript"
          src="https://www.google.com/jsapi?autoload={
            'modules':[{
              'name':'visualization',
              'version':'1',
              'packages':['corechart']
            }]
          }"></script>

    <script type="text/javascript">
      google.setOnLoadCallback(drawChart);

      function drawChart() {
        var data = google.visualization.arrayToDataTable([
%s
        ]);

        var options = {
          title: 'Tempo médio de resolução vs Tempo total trabalhado (horas)',
          curveType: 'function',
          legend: { position: 'bottom' },
        };

        var chart = new google.visualization.LineChart(document.getElementById('mean_time_to_resolve'));

        chart.draw(data, options);
      }
    </script>
""" % result






    <!--<tr>
        <td align="center"><a href="/detail/dir?o={{username_id}}">DIR</a></td>
        <td align="center"><a href="/detail/dir-inbox?o={{username_id}}">DIR-INBOX</a></td>
        <td align="center">DITIC Kanban Board</td>
    <tr> -->
    <section>
    <div class="row">
            <div class="col-md-8 col-md-offset-2 list-table">

                <ul class="nav nav-tabs" role="tablist">
                    <li role="presentation" class="active"><a href="#home" aria-controls="kaban-board" role="tab" data-toggle="tab">Kanban Board</a></li>
                </ul>
        % # DIR
        % sum = 0
        % # we need this code because DIR can have tickets all along several status
        % for status in summary['dir']:
        %   sum += summary['dir'][status]
        % end 
        <!--<td align="center" valign="top">{{sum}}</td>-->

        % # DIR-INBOX
        % sum = 0
        % # we need this code because DIR can have tickets all along several status
        % for status in summary['dir-inbox']:
        %   sum += summary['dir-inbox'][status]
        % end 

        <!--<td align="center" valign="top">-->
            % urgent = get('urgent', '')
            % if urgent:
            
            <table>
                <td>
                    URGENT<br>
                    <br>
                    % for ticket_info in urgent:
                      <audio autoplay="autoplay">
                         <source src="/static/alert1.mp3" />
                      </audio>
                        <a href="http://localhost:8080/Ticket/Display.html?id={{ticket_info['id']}}o={{username_id}}&email={{email}}">
                            {{ticket_info['subject']}}
                        </a>
                        % if username:
                        <a href="/ticket/{{ticket_info['id']}}/action/take?o={{username_id}}&email={{email}}">(take)</a>
                        % end
                    % end
                </td>
            </table>
            <br>
            % end
            <!--{{sum}}-->
        </td>
        <div class="content">
                    <div class="tab-content">
                        <div role="tabpanel" class="tab-pane active" id="kaban-board">

                            <table class="table">
                                <tr class="yellow"> 
                                    <td>USER</td>
                                    <td>IN</td>
                                    <td>ACTIVE</td>
                                    <td>STALLED</td>
                                    <td>DONE</td>
                                </tr>
                % totals = { status: 0 for status in ['new', 'open', 'stalled',  'resolved']}
                % for email in sorted(summary):
                %   if email.startswith('dir'):
                %       continue
                %   end
                %   user = email
                %   if  email != 'unknown':
                %       user = alias[email]
                %   end
                <tr>
                    % if username == email:
                    <td><a href="/detail/{{username}}?o={{username_id}}">{{user}}</a></td>
                    % else:
                    <td>{{user}}</td>
                    % end
                    %   for status in ['new', 'open', 'stalled', 'resolved']:
                    <td>{{summary[email][status]}}</td>
                    %       totals[status] += summary[email][status]
                    % end
                </tr>
                % end
                <tr>
                    <td><strong>Totais</strong></td>
                    %   for status in ['new', 'open', 'stalled', 'resolved']:
                    <td><strong>{{totals[status]}}</strong></td>
                    % end
                </tr>
            </table>
            </div>

        </div>
    </div>
    </div>
    </div>
    </tr>
    </section>

</table>




<script>
    $('#myTabs a').click(function (e) {
        e.preventDefault()
        $(this).tab('show')
    })
    </script>