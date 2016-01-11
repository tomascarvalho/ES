<!-- Novo ticket -->
<form action="/ticket/new?o={{username_id}}" method="post">
    <p> Novo Ticket</p>
    Subject: <input name="subject" type="text"> <br/>
    Description: <input name="description" type="text"> 
    <input type="submit" value="create_ticket">
</form>