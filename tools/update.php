<?php
echo "Pulling latest Spigot data...\n";

$spigot_data = json_decode(file_get_contents("https://hub.spigotmc.org/jenkins/job/BuildTools/api/json"), true);
$spigot_latest = $spigot_data["builds"][0]["number"];
$spigot_latest_download = "https://hub.spigotmc.org/jenkins/job/BuildTools/" . $spigot_latest . "/artifact/target/BuildTools.jar"; 
$spigot_latest_hash = hash('sha256', file_get_contents($spigot_latest_download));

echo "Found build tools version " . $spigot_latest . "\n";
echo "URL:    " . $spigot_latest_download . "\n";
echo "SHA256: " . $spigot_latest_hash . "\n";

echo "\nReading Dockerfile...\n";
$dockerfile = dirname(__DIR__) . "/image/Dockerfile";
$dockerfile_data = file_get_contents("$dockerfile");

$dockerfile_data = preg_replace("/SPIGOT_DOWNLOAD=\"[^\"]+\"/", "SPIGOT_DOWNLOAD=\"" . $spigot_latest_download . "\"", $dockerfile_data);
$dockerfile_data = preg_replace("/SPIGOT_DOWNLOAD_HASH=\"[^\"]+\"/", "SPIGOT_DOWNLOAD_HASH=\"" . $spigot_latest_hash . "\"", $dockerfile_data);

echo "Updating Dockerfile...\n";
$fh = fopen($dockerfile, 'w');
fwrite($fh, $dockerfile_data);
fclose($fh);

