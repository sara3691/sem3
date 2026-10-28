
<?php
$conn = mysqli_connect("localhost", "root", "", "college");

$result = mysqli_query($conn, "SELECT * FROM students");
echo "<center>";
echo "<h2>Student Details</h2>";
echo "<table border='1' cellpadding='10'>
<tr>
    <th>ID</th>
    <th>Name</th>
    <th>Course</th>
</tr>";

while ($row = mysqli_fetch_assoc($result)) {
    echo "<tr>
    <td>{$row['id']}</td>
    <td>{$row['name']}</td>
    <td>{$row['course']}</td>
    </tr>";
}

echo "</table>";
echo "</center>";
mysqli_close($conn);
?>
