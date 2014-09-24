<?php

require('rcs_function.php');


$agent_hostname = getenv('UPTIME_HOSTNAME');
$agent_port     = getenv('UPTIME_PORT');
$agent_password = getenv('UPTIME_PASSWORD');
$agent_cmd = '/opt/uptime-agent/scripts/fiber_channel_unix.ksh';

$agent_output = uptime_remote_custom_monitor($agent_hostname, $agent_port, $agent_password, $agent_cmd, "");
$lines = explode("\n", $agent_output);

$output_variable = "output ";

foreach ($lines as $line)
{
	if (!empty($line))
	{
		print $output_variable . $line . "\n";
	}
}



?>
