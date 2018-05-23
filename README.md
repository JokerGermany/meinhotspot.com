# meinhotspot.com
Automatisches Login in die WLan Netzwerke von meinhotspot.com mit Linux bzw. der Fritzbox.

## Funktionsweise des Script
Einmal gestartet läuft es, bis es gestoppt wird, in einer Endlosschleife. 
Es prüft beim Aufruf ob die 2 Stunden abgelaufen sind und wenn noch mehr als 5 Minuten bis zum ablaufen der Zeit ist, legt es sich wieder schlafen.
Ist die Zeit gekommt, loggt es sich automatisch aus dem Wlan aus und wieder ein.

## Linux Variante
Das Script muss ausführbar gemacht werden.
Im Script schreibt ersetzt man XX%3AXX%3AXX%3AXX%3AXX%3AXX mit der Mac Adresse der Fritzbox.
Beispiel: BB:BB:BB:BB:BB:BB ist die MAC Adresse, dann muss BB%3ABB%3ABB%3ABB%3ABB%3ABB eingetragen werden.
Dann kann das Script ausgeführt werden.

## Freetz Variante
Diese Variante setzt eine Fritz!Box mit installierten freetz (www.freetz.org) voraus.
Im Script schreibt ersetzt man XX%3AXX%3AXX%3AXX%3AXX%3AXX mit der Mac Adresse der Fritzbox.
Beispiel: BB:BB:BB:BB:BB:BB ist die MAC Adresse, dann muss BB%3ABB%3ABB%3ABB%3ABB%3ABB eingetragen werden.
Das Script speichert  man auf der Fritzbox z.B. unter auf dem NAS im Ordner FRITZ. 
Anschließend muss das Script über die Rudi-Shell (Freetz-Oberfläche -> System -> Rudi-Shell) oder telnet Ausführbar gemacht werden.
z.B. mit "chmod +x /var/media/ftp/FRITZ/meinhotspotschleife.sh"
Damit es beim starten der Fritz!Box ausgeführt wird empfehle ich es in die rc.custom ( Freetz-Oberfläche -> Freetz –> rc.custom) reinzuschreiben: 
delay MHSPOT '/var/media/ftp/FRITZ/meinhotspotschleife.sh'

## Support
Das Programm wird ausgeliefert wie es ist.
Ich werde voraussichtlich keinerlei updates oder fixes für diese Scripts nachliefern.

## Danksagung
Vielen Dank an @PeterPawn und allen anderen die mir geholfen haben.
http://www.ip-phone-forum.de/showthread.php?t=292187
https://forum.ubuntuusers.de/topic/nc-spoof-http-header/
