#!/usr/bin/env perl
use Mojolicious::Lite;
use Plack::Builder;
get '/' => sub {
    shift->redirect_to( "/20" );
};

get '/:minute' => sub {
  my $self = shift;
  my $minute = $self->param('minute');
  $self->stash->{first}   = abs (5 - $minute);
  $self->stash->{second}  = abs (1 - $minute);
  $self->stash->{third}   = $minute;
      
  $self->render('index');
};

builder {
    enable "Plack::Middleware::AccessLog", format => "combined";
    app->start;
}


__DATA__

@@ index.html.ep
% title 'Time keeper';
<!DOCTYPE HTML>
<html lang="ja">
<head>
<meta charset="utf-8" />
<title>Time Keeper</title>
<%= javascript '/js/jquery-1.6.4.min.js' %>
<%= javascript '/js/jquery.timer.js' %>
<%= javascript '/js/timekeeper.js' %>
<%= stylesheet '/css/bootstrap.min.css' %>
<%= stylesheet '/css/timekeeper.css' %>

</head>
<body>
    <div class="topbar">
      <div class="fill">
        <div class="container">
          <a class="brand" href="#">Time Keeper</a>
          <ul class="nav">
            <li id="standby" class="active"><a href="#standby">Standby</a></li>
            <li id="start"><a href="#start">Start</a></li>
            <li id="pause"><a href="#pause">Pause</a></li>
          </ul>
		  <form class="pull-left" action="">
			<input id="time1" type="text" style="width:5ex;" value="<%= $first %>:00">
			<input id="time2" type="text" style="width:5ex;" value="<%= $second %>:00">
			<input id="time3" type="text" style="width:5ex;" value="<%= $third %>:00">
		  </form>
          <ul class="nav second-nav">
            <li id="soundcheck"><a href="#soundcheck">Sound Check</a></li>
          </ul>
        </div>
      </div>
    </div>
	<div id="time">
		00:00
	</div>
	<div id="state">
		STANDBY
	</div>
	<div id="info">
		STANDBY
	</div>
</body>
</html>
