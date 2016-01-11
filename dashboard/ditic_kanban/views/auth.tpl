
% if message != '':
Result: <strong>{{message}}</strong>
% end

<!DOCTYPE html>
<html lang="en">
<head>

  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Login</title>
  <!-- CSS -->
  <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Roboto:400,100,300,500">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" integrity="sha512-dTfge/zgoMYpP7QbHy4gWMEGsbsdZeCXz7irItjcC3sPUFtf0kuFbDz/ixG7ArTxmDjLXDmezHubeNikyKGVyQ==" crossorigin="anonymous">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
  <link rel="stylesheet" href="https://student.dei.uc.pt/~tmdcc/form-elements.css">
  <link rel="stylesheet" href="https://student.dei.uc.pt/~tmdcc/style.css">
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
    % username = get('username','')
    % username_id = get('username_id','')
    </p>

      <!-- Top content -->
  <div class="top-content">    
    <div class="inner-bg">
      <div class="container">
        <div class="row">
          <div class="col-sm-6 col-sm-offset-3 form-box">
            <div class="form-top">
              <div class="form-top-left">
                <h3>Login to our site</h3>
                <p>Enter your username and password to log on:</p>
              </div>
              <div class="form-top-right">
                <i class="fa fa-lock"></i>
              </div>
            </div>
            <div class="form-bottom">
              <form role="form" action="/auth" method="post" class="login-form">
              <div class="form-group">
                <label class="sr-only form-username form-control" for="form-username" >Username</label>
                  <input name="username" type="text" placeholder= "Username..." value="{{get('username', '')}}" class ="form-username form-control"/>
              </div>
              <div class="form-group">
                <label class="sr-only form-password form-control" for="form-password">Password</label>
                  <input name="password" type="password" placeholder= "**********" value="{{get('password', '')}}" class="form-password form-control" />
              </div>
              <!-- <a href="/detail/{{username}}?o={{username_id}}" type="button" class="btn btn-warning">Sign in</a>-->
              <button type = "submit" class = "btn">Sign in!</button> 
        
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>
          
  </div>



</body>

</html>