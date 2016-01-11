<!DOCTYPE html>

<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Close ticket</title>
    <link rel="stylesheet" href="https://student.dei.uc.pt/~tmdcc/estilos.css"/>
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" integrity="sha512-dTfge/zgoMYpP7QbHy4gWMEGsbsdZeCXz7irItjcC3sPUFtf0kuFbDz/ixG7ArTxmDjLXDmezHubeNikyKGVyQ==" crossorigin="anonymous">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js">
    </script>

    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js" integrity="sha512-K1qjQ+NcF2TYO/eI3M6v8EiNYZfA95pQumfvcVrTHtwQVDG+aHRqLi/ETn2uB+1JqwYqVG3LIvdm9lj6imS/pQ==" crossorigin="anonymous"></script>

</head>

<body>

<br><br>
<br><br>

<!--
<form>
	Requestors: <input type="text" name="requestor"><br>
	Cc: <input type="text" name="cc"><br>
	<br><br>
	Admin Cc: <input type="text" name="admin_cc"><br>
	Subject: <input type="text" name="subject"><br>
	<br>
	<br>
	Describe the issue below:<br>
  	<input type="text" name="ticket size="50">
	<input type="submit" style="display: none" />
</form>
-->


<p>
	%ticket_id = get('ticket_id', '')
	% username_id = get('username_id','')
	% username = get('username','')
</p>


<div class="formSteve">
    
	<form  action = "/ticket/{{ticket_id}}/{{username_id}}/{{username}}/comment" id = "alwaysEnableButtonForm" method="post" class="form-horizontal">

		<br>
		<br>
		<div class="form-group">
        	<label class="col-xs-3 control-label">Justificação:</label><br>
        	<div class="col-xs-5">
            	<!--<textarea class="form-control" name="ticket_size" rows="5"></textarea>-->
				<textarea name="justificacao" rows="5"></textarea>
       		</div>
    	</div>
		<br>
		<br>
		
		<div class="form-group">
	        <div class="col-xs-5 col-xs-offset-3">
					<a href ="/detail/{{username}}?o={{username_id}}">
	   					<input type="submit" class = "btn btn-warning" value="Enviar" onclick="alertMsg()" />
					</a>

					<a href ="/detail/{{username}}?o={{username_id}}">
						<input type="button" class = "btn btn-warning" value="Cancelar" onclick="alertMsg_cancel()" />
					</a>
	        </div>
    	</div>
		
	</form>
</div>


<script>
	function alertMsg(){
		alert("Enviado!");
	}
</script>

<script>
	function alertMsg_cancel(){
		alert("Cancelado!");
	}
</script>



