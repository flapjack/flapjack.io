This is how events are turned into alerts, and how alerts are routed to contacts:

![notification routing](https://raw.github.com/wiki/flpjck/flapjack/notification-routing.gif)

#### Creating the above animation

1. Export [architecture diagrams](https://raw.github.com/wiki/flpjck/flapjack/Flapjack%20Architecture.key) to PNG
2. Run this shell:

``` bash
for f in *.png ; do convert $f $(basename $f .png).gif ; done
gifsicle --delay=200 --loop *.gif > anim.gif
```
