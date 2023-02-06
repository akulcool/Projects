
<?php
session_start();
include("database.php");
if(isset($_SESSION["admin"]) && $_SESSION["admin"]=="akul"){
?>


<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<title></title>


<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Itim&display=swap" rel="stylesheet">




<link rel="stylesheet" type="text/css" href="adminstyle.css">




	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">


</head>
<body>

<nav class="navbar navbar-expand-lg nav">
  <div class="container-fluid">
    <a class="navbar-brand" href="http://localhost/WRITER'S%20SOCIETY/admin/admin.php"><img src="WS.jpeg"  width="50" height="54"></a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
      <div class="navbar-nav">
        <a class="nav-link active" aria-current="page" href="post.php">Posts</a>
        <a class="nav-link" href="new.php">New</a>
        
      </div>
    </div>
  </div>
</nav>





<div class="container">

<?php

$sql="SELECT *FROM posts";
$result=mysqli_query($conn,$sql);

if(mysqli_num_rows($result)>0){
	echo"<ol>";
	while($row=mysqli_fetch_assoc($result)){
		echo "<li>";
		echo "<h4 class='title'>" .$row["title"]. "</h4>" ;
		echo "<p class='content'>".$row["content"]."</p>";
		echo "</li>";

	?>
	<a href="post.php?delete=<?php echo $row["id"]; ?>" class="btn btn-danger">delete</a>

	<?php
	}
	

	
echo"</ol>";
}

else{
	header("Location: http://localhost/WRITER'S%20SOCIETY/admin/y.php");
}



?>





</div>














<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
</body>
</html>

<?php

if(isset($_GET["delete"])){
	$delete=$_GET["delete"];

	$sql="DELETE FROM posts WHERE id='".$delete."'";
	if(!mysqli_query($conn,$sql)){
		echo "there was a problem deleting the post";
	}else{
		header("Location: http://localhost/WRITER'S%20SOCIETY/admin/x.php");
	}



}


}
else{
	header("Location: http://localhost/WRITER'S%20SOCIETY/admin/admin.php");
}

?>


