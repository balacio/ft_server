alias html='cd /var/www/html/'
alias lla='ls -la'
alias refresh='source ~/.bashrc'
alias restart-n='service nginx restart'
alias restart-p='service php7.3-fpm restart'
alias restart-m='service mysql restart'
alias sites-a='cd /etc/nginx/sites-available/'
alias vimdefault='vim /etc/nginx/sites-available/default'
alias cdhthml='cd /var/www/html/'
alias cdphp='cd /var/www/html/phpmyadmin'
alias vimbash='vim ~/.bashrc'

function restart-a {
	restart-n;
	restart-m;
	restart-p;
}


