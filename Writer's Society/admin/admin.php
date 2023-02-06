<?php
session_start();


?>


<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<title></title>

<style type="text/css">
  
#admin{
  background-image: linear-gradient(to right top, #39cfdb, #00bfdf, #00afe0, #009ddd, #268ad6);
  text-align: center;

}

#user{
  text-align: center;
    width: 400px;
    height: 30px;
    margin: auto;
}

#pass{
  width: 400px;
    height: 30px;
    margin:auto;
}
#xx{
  background-image: linear-gradient(to right top, #39cfdb, #00bfdf, #00afe0, #009ddd, #268ad6);
}


</style>




	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">


</head>
<body>

<nav class="navbar bg-body-tertiary " id="xx">
  <div class="container-fluid">
    <a class="navbar-brand" href="http://localhost/WRITER'S%20SOCIETY/main.php"><img src="home.png" width="40px"></a>
   
  </div>
</nav>

<form method="post" id="admin">
  
<h4 align="center">WELCOME TO THE ADMIN LOGIN PAGE!</h4>

  <div class="mb-3">
    <label for="exampleInputEmail1" class="form-label" >Username</label>
    <input type="text" class="form-control" id="user" name="username">
    
  </div>
  <div class="mb-3">
    <label for="exampleInputPassword1" class="form-label">Password</label>
    <input type="password" class="form-control" id="pass" name="password">
  </div>
  <div class="mb-3 form-check">
    
   
  </div>
  <button type="submit" class="btn btn-primary" name="sub">Login</button>
</form>






<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>

</body>

</html>


<?php
if(isset($_POST["sub"])){
  $un = $_POST["username"];
  $pw = $_POST["password"];
if($un=="akul" && $pw==12345){
$_SESSION["admin"]="akul";     //sessional variable

header("Location: post.php");
}else{
  echo "wrong password or username";
}



}


?>