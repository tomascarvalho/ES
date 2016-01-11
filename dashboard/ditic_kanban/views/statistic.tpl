<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="UTF-8">
	<title>Statistics</title>
	<link rel="stylesheet" href="https://student.dei.uc.pt/~tmdcc/estilos.css"/>
	<!-- Latest compiled and minified CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" integrity="sha512-dTfge/zgoMYpP7QbHy4gWMEGsbsdZeCXz7irItjcC3sPUFtf0kuFbDz/ixG7ArTxmDjLXDmezHubeNikyKGVyQ==" crossorigin="anonymous">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js">
	</script>

	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js" integrity="sha512-K1qjQ+NcF2TYO/eI3M6v8EiNYZfA95pQumfvcVrTHtwQVDG+aHRqLi/ETn2uB+1JqwYqVG3LIvdm9lj6imS/pQ==" crossorigin="anonymous"></script>

</head>

<body>

	<!-- NAVIGATION BAR -->
    <nav class="navbar navbar-default navigation">
        <div class="container-fluid">
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav">
                    <li><a href="/detail/main?o={{username_id}}">Home</a></li>
                    % if email =='dir':
                    <li><a href="/detail/dir?o={{username_id}}">DIR</a></li>
                    % else:
                    <li><a href="/detail/dir?o={{username_id}}">DIR</a></li>
                    % end
                    % if email != 'dir':
                    <li><a class= "active" href="/detail/dir-inbox?o={{username_id}}">DIR-INBOX</a></li>
                    % else:
                    <li><a href="/detail/dir-inbox?o={{username_id}}">DIR-INBOX</a></li>
                    % end
                    <li class = "active"><a href="/detail/statistic?o={{username_id}}">Statistics</a></li>
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

% rebase('skin', meta_refresh=300)


<table border="0">
    <td>
        <div id="performance" style="width: 650px; height: 400px"></div>
    </td>
    <td>
        <div id="mean_time_to_resolve" style="width: 650px; height: 400px"></div>
    </td>
</table>

</body>

<script>
$('#myTabs a').click(function (e) {
	e.preventDefault()
	$(this).tab('show')
})
</script>


</html>



