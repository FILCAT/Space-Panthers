<?php
​
// Set the timezone to the desired location
date_default_timezone_set('America/New_York');
​
// Create a timestamp for the current time
$timestamp = date('m_d_y');
​
// Set the LOTUS_BACKUP_BASE_PATH path for the file
$file_path = '/YOUR/BACKUP/PATH';
​
// Run the command to backup the file with the current timestamp as the filename
exec('lotus-miner backup ' . $file_path . $timestamp . '.cbor');
​
?>