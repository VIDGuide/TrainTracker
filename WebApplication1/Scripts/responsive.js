// JAVASCRIPT MEDIA QUERY

var queries = [
    {
        context: 'mobile',
        callback: function () {
            console.log('Mobile callback. Maybe hook up some tel: numbers?');
            // Your mobile specific logic can go here. 


            // set EVERY 'state' here so will undo ALL layout changes
            // used by the 'Reset State' button: myLayout.loadState( stateResetSettings )
            var stateResetSettings = {
                north__size: 43
            , north__initClosed: false
            , north__initHidden: false
            , south__size: "auto"
            , south__initClosed: true
            , south__initHidden: true
            , west__size: 225
            , west__initClosed: false
            , west__initHidden: false
            , east__size: 290
            , east__initClosed: true
            , east__initHidden: false
            };

            var myLayout;

            $(document).ready(function () {

                // this layout could be created with NO OPTIONS - but showing some here just as a sample...
                // myLayout = $('body').layout(); -- syntax with No Options

                myLayout = $('body').layout({

                    //  enable showOverflow on west-pane so CSS popups will overlap north pane
                    west__showOverflowOnHover: false

                    //  reference only - these options are NOT required because 'true' is the default
            , closable: true    // pane can open & close
            , resizable: true    // when open, pane can be resized 
            , slidable: true    // when closed, pane can 'slide' open over other panes - closes on mouse-out

                    //  some resizing/toggling settings
            , north__slidable: false   // OVERRIDE the pane-default of 'slidable=true'
            , south__resizable: false   // OVERRIDE the pane-default of 'resizable=true'
            , north__resizable: false   // OVERRIDE the pane-default of 'resizable=true'
            , north__size: 43  // OVERRIDE the pane-default of 'resizable=true'
            , south__size: 0   // OVERRIDE the pane-default of 'resizable=true'
            , south__spacing_open: 0       // no resizer-bar when open (zero height)
            , north__spacing_open: 0       // no resizer-bar when open (zero height)
            , south__spacing_closed: 0       // big resizer-bar when open (zero height)
            , east__initClosed: true
            , west__initClosed: false
            , south__initClosed: true
                    //  some pane-size settings
            , west__minSize: 190
            , west__size: 225
            , east__size: 290
            , east__minSize: 200
            , east__maxSize: Math.floor(screen.availWidth / 2) // 1/2 screen width
            , center__minWidth: 100

            , useStateCookie: true
                });


                myLayout.destroy();


            });

        }
    },
    {
        context: 'tablet',
        callback: function () {
            console.log('tablet callback! Swap the class on the body element.');
            // Your tablet specific logic can go here.


            // set EVERY 'state' here so will undo ALL layout changes
            // used by the 'Reset State' button: myLayout.loadState( stateResetSettings )
            var stateResetSettings = {
                north__size: 43
            , north__initClosed: false
            , north__initHidden: false
            , south__size: "auto"
            , south__initClosed: true
            , south__initHidden: true
            , west__size: 190
            , west__initClosed: false
            , west__initHidden: false
            , east__size: 290
            , east__initClosed: true
            , east__initHidden: false
            };

            var myLayout;

            $(document).ready(function () {

                // this layout could be created with NO OPTIONS - but showing some here just as a sample...
                // myLayout = $('body').layout(); -- syntax with No Options

                myLayout = $('body').layout({

                    //  enable showOverflow on west-pane so CSS popups will overlap north pane
                    west__showOverflowOnHover: false

                    //  reference only - these options are NOT required because 'true' is the default
            , closable: true    // pane can open & close
            , resizable: true    // when open, pane can be resized 
            , slidable: true    // when closed, pane can 'slide' open over other panes - closes on mouse-out

                    //  some resizing/toggling settings
            , north__slidable: false   // OVERRIDE the pane-default of 'slidable=true'
            , south__resizable: false   // OVERRIDE the pane-default of 'resizable=true'
            , north__resizable: false   // OVERRIDE the pane-default of 'resizable=true'
            , north__size: 43  // OVERRIDE the pane-default of 'resizable=true'
            , south__size: 0   // OVERRIDE the pane-default of 'resizable=true'
            , south__spacing_open: 0       // no resizer-bar when open (zero height)
            , north__spacing_open: 0       // no resizer-bar when open (zero height)
            , south__spacing_closed: 0       // big resizer-bar when open (zero height)
            , east__initClosed: true
            , west__initClosed: false
            , south__initClosed: true
                    //  some pane-size settings
            , west__minSize: 190
            , west__size: 190
            , east__size: 290
            , east__minSize: 200
            , east__maxSize: Math.floor(screen.availWidth / 2) // 1/2 screen width
            , center__minWidth: 100

            , useStateCookie: true
                });

                myLayout.loadState(stateResetSettings);

                //myLayout.panes.hide(); 
                //myLayout.resizers.hide(); 
                //myLayout.destroy(); 



            });

        }
    },
    {
        context: 'tabletPortrait',
        callback: function () {
            console.log('tabletPortrait callback! Swap the class on the body element.');
            // Your tablet specific logic can go here.



            // set EVERY 'state' here so will undo ALL layout changes
            // used by the 'Reset State' button: myLayout.loadState( stateResetSettings )
            var stateResetSettings = {
                north__size: 43
            , north__initClosed: false
            , north__initHidden: false
            , south__size: "auto"
            , south__initClosed: true
            , south__initHidden: true
            , west__size: 225
            , west__initClosed: false
            , west__initHidden: false
            , east__size: 290
            , east__initClosed: true
            , east__initHidden: false
            };

            var myLayout;

            $(document).ready(function () {

                // this layout could be created with NO OPTIONS - but showing some here just as a sample...
                // myLayout = $('body').layout(); -- syntax with No Options

                myLayout = $('body').layout({

                    //  enable showOverflow on west-pane so CSS popups will overlap north pane
                    west__showOverflowOnHover: false

                    //  reference only - these options are NOT required because 'true' is the default
            , closable: true    // pane can open & close
            , resizable: true    // when open, pane can be resized 
            , slidable: true    // when closed, pane can 'slide' open over other panes - closes on mouse-out

                    //  some resizing/toggling settings
            , north__slidable: false   // OVERRIDE the pane-default of 'slidable=true'
            , south__resizable: false   // OVERRIDE the pane-default of 'resizable=true'
            , north__resizable: false   // OVERRIDE the pane-default of 'resizable=true'
            , north__size: 43  // OVERRIDE the pane-default of 'resizable=true'
            , south__size: 0   // OVERRIDE the pane-default of 'resizable=true'
            , south__spacing_open: 0       // no resizer-bar when open (zero height)
            , north__spacing_open: 0       // no resizer-bar when open (zero height)
            , south__spacing_closed: 0       // big resizer-bar when open (zero height)
            , east__initClosed: true
            , west__initClosed: false
            , south__initClosed: true
                    //  some pane-size settings
            , west__minSize: 190
            , west__size: 225
            , east__size: 290
            , east__minSize: 200
            , east__maxSize: Math.floor(screen.availWidth / 2) // 1/2 screen width
            , center__minWidth: 100

            , useStateCookie: true
                });

                myLayout.hide('west');


            });


        }
    },
    {
        context: 'desktop',
        callback: function () {
            console.log('wide-screen callback woohoo! Load some heavy desktop JS badddness.');
            // your desktop specific logic can go here.


            //Gritter Growl Welcome

            $(function () {
                $.gritter.add({
                    // (string | mandatory) the heading of the notification
                    title: 'Welcome to Clarity!',
                    // (int | optional) the time you want it to be alive for before fading out (milliseconds)
                    time: 6000,
                    // (string | optional) the image to display on the left
                    image: 'img/BryanMcAnulty.png',
                    // (string | mandatory) the text inside the notification
                    text: 'Be sure to explore all the great features!'
                });
            });

            $(function () {

                setTimeout(function () {
                    $.gritter.add({
                        // (string | mandatory) the heading of the notification
                        title: 'Ashley Green',
                        // (int | optional) the time you want it to be alive for before fading out (milliseconds)
                        time: 5000,
                        // (string | optional) the image to display on the left
                        image: 'img/2.jpg',
                        // (string | mandatory) the text inside the notification
                        text: 'Posted a new comment in the Redesign Client Site project.'
                    });
                }, 16000);
            });

            //UI Layout

            $(function () {
                var pageviews = [[0, 1040], [1, 1020], [2, 1243], [3, 1277], [4, 1020], [5, 1274], [6, 1421], [7, 1337], [8, 1000], [9, 778], [10, 838], [11, 1045], [12, 1570], [13, 1602], [14, 938], [15, 920], [16, 1515], [17, 1052], [18, 778], [19, 1237], [20, 1660], [21, 1838], [22, 1912], [23, 1780]],
                    visitors = [[0, 500], [1, 752], [2, 848], [3, 677], [4, 790], [5, 1052], [6, 868], [7, 567], [8, 600], [9, 638], [10, 488], [11, 408], [12, 770], [13, 802], [14, 928], [15, 1250], [16, 615], [17, 1352], [18, 1378], [19, 1437], [20, 860], [21, 1538], [22, 1612], [23, 1680]],
                    users = [[0, 120], [1, 172], [2, 228], [3, 250], [4, 215], [5, 482], [6, 378], [7, 437], [8, 260], [9, 338], [10, 412], [11, 680], [12, 470], [13, 302], [14, 628], [15, 250], [16, 215], [17, 352], [18, 378], [19, 257], [20, 550], [21, 708], [22, 812], [23, 980]];



                var plot = $.plot($("#lineChart"),
                       [{ color: "#1c9cff", data: pageviews, label: "Pageviews" }, { color: "#dd188a", data: users, label: "Users" }, { color: "#ff771c", data: visitors, label: "Visitors"}], {
                           series: {
                               lines: { show: true },
                               points: { show: true }
                           },
                           grid: { hoverable: true, clickable: true, borderColor: "#ddd", backgroundColor: "#efefef" }
                       });
            });

            //jScrollPane Custom Scrollbar Below

            $(function () {
                $('.scroll-pane').each(
                function () {
                    $(this).jScrollPane(
                    {
                        showArrows: $(this).is('.arrow')
                    }
                  );
                    var api = $(this).data('jsp');
                    var throttleTimeout;
                    $(window).bind('resize', function () {
                        if ($.browser.msie) {
                            // IE fires multiple resize events while you are dragging the browser window which
                            // causes it to crash if you try to update the scrollpane on every one. So we need
                            // to throttle it to fire a maximum of once every 50 milliseconds...
                            if (!throttleTimeout) {
                                throttleTimeout = setTimeout(
                            function () {
                                api.reinitialise();
                                throttleTimeout = null;
                            }, 50);
                            }
                        } else {
                            api.reinitialise();
                        }
                    });
                }
              )
            });
            // Fade jScrollpane Scrollbar in an out when cursor enters or leaves container
            $(document).ready(function () {
                $(".scroll-pane").hover(
                function () {
                    $(".jspDrag").stop().animate({ "opacity": "1" }, "slow");
                },
                function () {
                    $(".jspDrag").stop().animate({ "opacity": "0" }, "slow");
                });
            });


            // jQuery UI Layout Below


            // set EVERY 'state' here so will undo ALL layout changes
            // used by the 'Reset State' button: myLayout.loadState( stateResetSettings )
            var stateResetSettings = {
                north__size: 43
                , north__initClosed: false
                , north__initHidden: false
                , south__size: "auto"
                , south__initClosed: true
                , resizeWhileDragging: true
                , south__initHidden: true
                , west__size: 225
                , west__initClosed: false
                , west__initHidden: false
                , east__size: 290
                , east__initClosed: true
                , east__initHidden: false
            };

            var myLayout;

            $(document).ready(function () {

                // this layout could be created with NO OPTIONS - but showing some here just as a sample...
                // myLayout = $('body').layout(); -- syntax with No Options

                myLayout = $('body').layout({

                    //  enable showOverflow on west-pane so CSS popups will overlap north pane
                    west__showOverflowOnHover: false

                    //  reference only - these options are NOT required because 'true' is the default
                , closable: true    // pane can open & close
                , resizable: true    // when open, pane can be resized 
                , slidable: true    // when closed, pane can 'slide' open over other panes - closes on mouse-out

                    //  some resizing/toggling settings
                , north__slidable: false   // OVERRIDE the pane-default of 'slidable=true'
                , south__resizable: false   // OVERRIDE the pane-default of 'resizable=true'
                , north__resizable: false   // OVERRIDE the pane-default of 'resizable=true'
                , north__size: 43  // OVERRIDE the pane-default of 'resizable=true'
                , south__size: 0   // OVERRIDE the pane-default of 'resizable=true'
                , south__spacing_open: 0       // no resizer-bar when open (zero height)
                , north__spacing_open: 0       // no resizer-bar when open (zero height)
                , south__spacing_closed: 0       // big resizer-bar when open (zero height)
                , east__initClosed: true
                , west__initClosed: false
                , south__initClosed: true
                , resizeWhileDragging: true
                    //  some pane-size settings
                , west__minSize: 190
                , west__size: 225
                , east__size: 290
                , east__minSize: 200
                , east__maxSize: Math.floor(screen.availWidth / 2) // 1/2 screen width
                , center__minWidth: 100

                , useStateCookie: true
                });

                drag = $('#dragb');
                //drag.css({ left: myLayout.state.west.offsetLeft + 130 });

                // Drag splitter handle
                drag.draggable({
                    scroll: false,
                    containment: "body",
                    axis: "x",
                    drag: function (event, ui) {
                        myLayout.sizePane("west", ui.offset.left + 30);
                    }
                });

                myLayout.slideOpen("west");
                myLayout.loadState(stateResetSettings);




                myLayout.addToggleBtn('#slideleftb', 'west');
                myLayout.addToggleBtn('#sliderightb', 'east');
                myLayout.addToggleBtn('#fullscreenb', 'north');

            });
        }
    }
];
// Go!
MQ.init(queries);
