<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="UTF-8">
	<title>Create new ticket</title>
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
                   
        			<li><a href="/detail/dir?o={{username_id}}">DIR</a></li>
                  
                    
                    
                    <li><a href="/detail/dir-inbox?o={{username_id}}">DIR-INBOX</a></li>
                    
                    <li><a href="/detail/statistic?o={{username_id}}">Statistics</a></li>
                    <li><a href="/detail/history?o={{username_id}}" >Archive</a></li>
                    <li class = "active"><a href="/detail/new_ticket?o={{username_id}}">New Ticket</a></li>
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
					<li role="presentation" class="active historic-tab"><a href="#home" aria-controls="kaban-board" role="tab" data-toggle="tab">New Ticket</a></li>
				</ul>

				<div class="content">
					<div class="tab-content">
						<div role="tabpanel" class="tab-pane active" id="kaban-board">
					
						<form class = "input-group" action="/ticket/new?o={{username_id}}" method="post">
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
								<div class="col-md-2 col-md-offset-10 btn">
									<div class="btn-group" role="group" aria-label="...">
										<input type="submit" value="Create Ticket">
									</div>
								</div>
							</div>
						</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
</body>
</html>
