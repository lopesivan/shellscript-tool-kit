<?php

/*
 * 1. parameter: channel-name
 *
 * 2. parameter: number of pages to get
 *
 * example: "php.exe getyoutubelinks.php channelname 0" to get latest 20
 * videos (1 to get 40 ...)
 *
 */

$currentstart = 1;
$url = 'http://gdata.youtube.com/feeds/base/playlists/EF032FFFCDB17840?start-index=1&max-results=50';
	{
		$input=file_get_contents($url);
		preg_match_all('#(http://www.youtube.com)?/(v/([-|~_0-9A-Za-z]+)|watch\?v\=([-|~_0-9A-Za-z]+)&?.*?)#i',$input,$output);
		// remove duplicates
		//$clean = $output[4];
		$clean = array_unique($output[4]);
		// echo valid links
		foreach ($clean AS $video_id) {
			echo "http://www.youtube.com/watch?v=$video_id\n";
		}
		// for debugging gets all the output
		//print_r($output);

	}

