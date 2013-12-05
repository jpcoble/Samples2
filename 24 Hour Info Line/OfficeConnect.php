<?php
 
    
    if($_REQUEST['Digits'] != '8') {
        header("Location: handle-user-input.php");
        die;
    }
     
    
    header("content-type: text/xml");
    echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n";
?>
<Response>
    <Dial>+1205XXXXXXX</Dial>
    <Say>The call failed or the remote party hung up. Goodbye.</Say>
</Response>