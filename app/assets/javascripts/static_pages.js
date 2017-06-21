/*
 * Superfish v1.4.8 - jQuery menu widget
 * Copyright (c) 2008 Joel Birch
 *
 * Dual licensed under the MIT and GPL licenses:
 *  http://www.opensource.org/licenses/mit-license.php
 *  http://www.gnu.org/licenses/gpl.html
 *
 * CHANGELOG: http://users.tpg.com.au/j_birch/plugins/superfish/changelog.txt
 */
;
(function($) {
  $.fn.superfish = function(op) {

    var sf = $.fn.superfish,
      c = sf.c,
      $arrow = $(['<span class="', c.arrowClass, '"> &#187;</span>'].join('')),
      over = function() {
        var $$ = $(this),
          menu = getMenu($$);
        clearTimeout(menu.sfTimer);
        $$.showSuperfishUl().siblings().hideSuperfishUl();
      },
      out = function() {
        var $$ = $(this),
          menu = getMenu($$),
          o = sf.op;
        clearTimeout(menu.sfTimer);
        menu.sfTimer = setTimeout(function() {
          o.retainPath = ($.inArray($$[0], o.$path) > -1);
          $$.hideSuperfishUl();
          if (o.$path.length && $$.parents(['li.', o.hoverClass].join('')).length < 1) {
            over.call(o.$path);
          }
        }, o.delay);
      },
      getMenu = function($menu) {
        var menu = $menu.parents(['ul.', c.menuClass, ':first'].join(''))[0];
        sf.op = sf.o[menu.serial];
        return menu;
      },
      addArrow = function($a) {
        $a.addClass(c.anchorClass).append($arrow.clone());
      };

    return this.each(function() {
      var s = this.serial = sf.o.length;
      var o = $.extend({}, sf.defaults, op);
      o.$path = $('li.' + o.pathClass, this).slice(0, o.pathLevels).each(function() {
        $(this).addClass([o.hoverClass, c.bcClass].join(' '))
          .filter('li:has(ul)').removeClass(o.pathClass);
      });
      sf.o[s] = sf.op = o;

      $('li:has(ul)', this)[($.fn.hoverIntent && !o.disableHI) ? 'hoverIntent' : 'hover'](over, out).each(function() {
          if (o.autoArrows) addArrow($('>a:first-child', this));
        })
        .not('.' + c.bcClass)
        .hideSuperfishUl();

      var $a = $('a', this);
      $a.each(function(i) {
        var $li = $a.eq(i).parents('li');
      });
      o.onInit.call(this);

    }).each(function() {
      var menuClasses = [c.menuClass];
      if (sf.op.dropShadows && !($.browser.msie && $.browser.version < 7)) menuClasses.push(c.shadowClass);
      $(this).addClass(menuClasses.join(' '));
    });
  };

  var sf = $.fn.superfish;
  sf.o = [];
  sf.op = {};
  sf.IE7fix = function() {
    var o = sf.op;
    if ($.browser.msie && $.browser.version > 6 && o.dropShadows && o.animation.opacity != undefined)
      this.toggleClass(sf.c.shadowClass + '-off');
  };
  sf.c = {
    bcClass: 'sf-breadcrumb',
    menuClass: 'sf-js-enabled',
    anchorClass: 'sf-with-ul',
    arrowClass: 'sf-sub-indicator',
    shadowClass: 'sf-shadow'
  };
  sf.defaults = {
    hoverClass: 'sfHover',
    pathClass: 'overideThisToUse',
    pathLevels: 2,
    delay: 1000,
    animation: {
      height: 'show'
    },
    speed: 'normal',
    autoArrows: false,
    dropShadows: false,
    disableHI: false, // true disables hoverIntent detection
    onInit: function() {}, // callback functions
    onBeforeShow: function() {},
    onShow: function() {},
    onHide: function() {}
  };
  $.fn.extend({
    hideSuperfishUl: function() {
      var o = sf.op,
        not = (o.retainPath === true) ? o.$path : '';
      o.retainPath = false;
      var $ul = $(['li.', o.hoverClass].join(''), this).add(this).not(not).removeClass(o.hoverClass)
        .find('>ul').hide();
      o.onHide.call($ul);
      return this;
    },
    showSuperfishUl: function() {
      var o = sf.op,
        sh = sf.c.shadowClass + '-off',
        $ul = this.addClass(o.hoverClass)
        .find('>ul:hidden');
      sf.IE7fix.call($ul);
      o.onBeforeShow.call($ul);
      $ul.animate(o.animation, o.speed, function() {
        sf.IE7fix.call($ul);
        o.onShow.call($ul);
      });
      return this;
    }
  });

})(jQuery);
/*---------------------*/
$(function() {
  $('.sf-menu').superfish({
    speed: 'fast'
  });
})


var makeBSS = function(el, options) {
  var $slideshows = document.querySelectorAll(el), // a collection of all of the slideshow
    $slideshow = {},
    Slideshow = {
      init: function(el, options) {
        this.counter = 0; // to keep track of current slide
        this.el = el; // current slideshow container    
        this.$items = el.querySelectorAll('figure'); // a collection of all of the slides, caching for performance
        this.numItems = this.$items.length; // total number of slides
        options = options || {}; // if options object not passed in, then set to empty object 
        options.auto = options.auto || false; // if options.auto object not passed in, then set to false
        this.opts = {
          auto: (typeof options.auto === "undefined") ? false : options.auto,
          speed: (typeof options.auto.speed === "undefined") ? 1500 : options.auto.speed,
          pauseOnHover: (typeof options.auto.pauseOnHover === "undefined") ? false : options.auto.pauseOnHover,
          fullScreen: (typeof options.fullScreen === "undefined") ? false : options.fullScreen,
          swipe: (typeof options.swipe === "undefined") ? false : options.swipe
        };

        this.$items[0].classList.add('bss-show'); // add show class to first figure 
        this.injectControls(el);
        this.addEventListeners(el);
        if (this.opts.auto) {
          this.autoCycle(this.el, this.opts.speed, this.opts.pauseOnHover);
        }
        if (this.opts.fullScreen) {
          this.addFullScreen(this.el);
        }
        if (this.opts.swipe) {
          this.addSwipe(this.el);
        }
      },
      showCurrent: function(i) {
        // increment or decrement this.counter depending on whether i === 1 or i === -1
        if (i > 0) {
          this.counter = (this.counter + 1 === this.numItems) ? 0 : this.counter + 1;
        } else {
          this.counter = (this.counter - 1 < 0) ? this.numItems - 1 : this.counter - 1;
        }

        // remove .show from whichever element currently has it 
        // http://stackoverflow.com/a/16053538/2006057
        [].forEach.call(this.$items, function(el) {
          el.classList.remove('bss-show');
        });

        // add .show to the one item that's supposed to have it
        this.$items[this.counter].classList.add('bss-show');
      },
      injectControls: function(el) {
        // build and inject prev/next controls
        // first create all the new elements
        var spanPrev = document.createElement("span"),
          spanNext = document.createElement("span"),
          docFrag = document.createDocumentFragment();

        // add classes
        spanPrev.classList.add('bss-prev');
        spanNext.classList.add('bss-next');

        // add contents
        spanPrev.innerHTML = '&laquo;';
        spanNext.innerHTML = '&raquo;';

        // append elements to fragment, then append fragment to DOM
        docFrag.appendChild(spanPrev);
        docFrag.appendChild(spanNext);
        el.appendChild(docFrag);
      },
      addEventListeners: function(el) {
        var that = this;
        el.querySelector('.bss-next').addEventListener('click', function() {
          that.showCurrent(1); // increment & show
        }, false);

        el.querySelector('.bss-prev').addEventListener('click', function() {
          that.showCurrent(-1); // decrement & show
        }, false);

        el.onkeydown = function(e) {
          e = e || window.event;
          if (e.keyCode === 37) {
            that.showCurrent(-1); // decrement & show
          } else if (e.keyCode === 39) {
            that.showCurrent(1); // increment & show
          }
        };
      },
      autoCycle: function(el, speed, pauseOnHover) {
        var that = this,
          interval = window.setInterval(function() {
            that.showCurrent(1); // increment & show
          }, speed);

        if (pauseOnHover) {
          el.addEventListener('mouseover', function() {
            interval = clearInterval(interval);
          }, false);
          el.addEventListener('mouseout', function() {
            interval = window.setInterval(function() {
              that.showCurrent(1); // increment & show
            }, speed);
          }, false);
        } // end pauseonhover

      },
      addFullScreen: function(el) {
        var that = this,
          fsControl = document.createElement("span");

        fsControl.classList.add('bss-fullscreen');
        el.appendChild(fsControl);
        el.querySelector('.bss-fullscreen').addEventListener('click', function() {
          that.toggleFullScreen(el);
        }, false);
      },
      addSwipe: function(el) {
        var that = this,
          ht = new Hammer(el);
        ht.on('swiperight', function(e) {
          that.showCurrent(-1); // decrement & show
        });
        ht.on('swipeleft', function(e) {
          that.showCurrent(1); // increment & show
        });
      },
      toggleFullScreen: function(el) {
        // https://developer.mozilla.org/en-US/docs/Web/Guide/API/DOM/Using_full_screen_mode
        if (!document.fullscreenElement && // alternative standard method
          !document.mozFullScreenElement && !document.webkitFullscreenElement &&
          !document.msFullscreenElement) { // current working methods
          if (document.documentElement.requestFullscreen) {
            el.requestFullscreen();
          } else if (document.documentElement.msRequestFullscreen) {
            el.msRequestFullscreen();
          } else if (document.documentElement.mozRequestFullScreen) {
            el.mozRequestFullScreen();
          } else if (document.documentElement.webkitRequestFullscreen) {
            el.webkitRequestFullscreen(el.ALLOW_KEYBOARD_INPUT);
          }
        } else {
          if (document.exitFullscreen) {
            document.exitFullscreen();
          } else if (document.msExitFullscreen) {
            document.msExitFullscreen();
          } else if (document.mozCancelFullScreen) {
            document.mozCancelFullScreen();
          } else if (document.webkitExitFullscreen) {
            document.webkitExitFullscreen();
          }
        }
      } // end toggleFullScreen

    }; // end Slideshow object 

  // make instances of Slideshow as needed
  [].forEach.call($slideshows, function(el) {
    $slideshow = Object.create(Slideshow);
    $slideshow.init(el, options);
  });
};
var opts = {
  auto: {
    speed: 5000,
    pauseOnHover: true
  },
  fullScreen: true,
  swipe: true
};
makeBSS('.demo1', opts);

