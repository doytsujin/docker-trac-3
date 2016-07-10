#!/bin/bash
sleep 10
trac-admin ./project initenv "Project" postgres://trac:tracpwd@postgres/tracdb?client_encoding=utf8
trac-admin ./project permission add anonymous TRAC_ADMIN
cp ./logo.png ./project/htdocs/your_project_logo.png

#plugins
cd /tmp
svn export http://svn.osdn.jp/svnroot/shibuya-trac/plugins/ganttcalendarplugin/trunk
cd trunk;python setup.py bdist_egg;easy_install dist/*.egg
cd /home/trac/src/project/conf
rm -rf /tmp/trunk
#https://trac-hacks.org/wiki/GanttCalendarPlugin
/usr/local/bin/edit_ini.py trac.ini add components ganttcalendar.admin.holidayadminpanel enabled
/usr/local/bin/edit_ini.py trac.ini add components ganttcalendar.complete_by_close.completeticketobserver  enabled
/usr/local/bin/edit_ini.py trac.ini add components ganttcalendar.ticketcalendar.ticketcalendarplugin  enabled
/usr/local/bin/edit_ini.py trac.ini add components ganttcalendar.ticketgantt.ticketganttchartplugin  enabled
/usr/local/bin/edit_ini.py trac.ini add components ganttcalendar.ticketvalidator.ticketvalidator  enabled

/usr/local/bin/edit_ini.py trac.ini add mainnav ticketgantt.label "Ticket Gantt"
/usr/local/bin/edit_ini.py trac.ini add mainnav ticketcalendar.label "Ticket Calendar"

/usr/local/bin/edit_ini.py trac.ini add ticket-custom complete select
/usr/local/bin/edit_ini.py trac.ini add ticket-custom complete.label "Completed [%%]"
sed -i -r 's/complete\.label\ =\ Completed\ \[%%\]/complete\.label\ =\ Completed \[%\]/' trac.ini
/usr/local/bin/edit_ini.py trac.ini add ticket-custom complete.options "|0|5|10|15|20|25|30|35|40|45|50|55|60|65|70|75|80|85|90|95|100"

/usr/local/bin/edit_ini.py trac.ini add ticket-custom complete.order 3
/usr/local/bin/edit_ini.py trac.ini add ticket-custom due_assign text
/usr/local/bin/edit_ini.py trac.ini add ticket-custom due_assign.label "Start (YYYY-MM-DD)"
/usr/local/bin/edit_ini.py trac.ini add ticket-custom due_assign.order 1
/usr/local/bin/edit_ini.py trac.ini add ticket-custom due_close text
/usr/local/bin/edit_ini.py trac.ini add ticket-custom due_close.label "End (YYYY-MM-DD)"
/usr/local/bin/edit_ini.py trac.ini add ticket-custom due_close.order 2

/usr/local/bin/edit_ini.py trac.ini add ganttcalendar complete_conditions "fixed, invalid"
/usr/local/bin/edit_ini.py trac.ini add ganttcalendar default_zoom_mode 1
/usr/local/bin/edit_ini.py trac.ini add ganttcalendar first_day 0
/usr/local/bin/edit_ini.py trac.ini add ganttcalendar format "%%Y-%%m-%%d"
sed -i -r 's/format\ =\ %%Y-%%m-%%d/format\ =\ %Y-%m-%d/' trac.ini
/usr/local/bin/edit_ini.py trac.ini add ganttcalendar show_ticket_summary "false"
/usr/local/bin/edit_ini.py trac.ini add ganttcalendar show_weekly_view "false"



cd /home/trac/src
tracd --port 8000 ./project

