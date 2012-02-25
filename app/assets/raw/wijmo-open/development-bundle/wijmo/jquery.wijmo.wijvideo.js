/*globals jQuery,window,document*/
/*
 * 
 * Wijmo Library 2.0.0
 * http://wijmo.com/
 * 
 * Copyright(c) ComponentOne, LLC.  All rights reserved.
 * 
 * Dual licensed under the Wijmo Commercial or GNU GPL Version 3 licenses.
 * licensing@wijmo.com
 * http://www.wijmo.com/license
 * 
 * 
 * Wijmo Video widget.
 * 
 * Depends:
 *     jquery.ui.core.js
 *     jquery.ui.widget.js
 *     jquery.wijmo.wijtooltip.js
 */
(function ($) {
	"use strict";
	var $video, $vidParent, $seekSlider, seek = false, fullScreen = false,
		currentVolumn, $volumeSlider, $volumeBtn, $fullScreenBtn;
	$.widget("wijmo.wijvideo", {

		_create: function () {
			var self = this, pos, $playbtn, videoIsSupport,
				interval; 

			if ($(this.element).is("video")) {
				$video = $(this.element);
			} else {
				$video = $(this.element).find("video");
			}
			//update for fixing bug 18129 by wh at 2011/11/2
			if (!$video || $video.length === 0 ||
					($.browser.msie && $.browser.version < 9)) {
				return;
			}
			//end for fixing
			
			//Add for fixing bug 18204 by wh at 2011/11/7
			videoIsSupport = $video[0].canPlayType;
			if (!videoIsSupport) {
				return;
			}
			//end for fixing bug 18204

			$video.wrap('<div class="wijmo-wijvideo ui-widget-content ui-widget" />')
				.after('<div class="wijmo-wijvideo-wrapper">' +
							'<ul class="wijmo-wijvideo-controls ui-widget-header ui-helper-clearfix ui-helper-reset">' +
								'<li class="wijmo-wijvideo-play ui-state-default ui-corner-all">' +
									'<span class="ui-icon ui-icon-play"></span>' +
								'</li>' +
								'<li class="wijmo-wijvideo-index"><div class="wijmo-wijvideo-index-slider"></div></li>' +
								'<li class="wijmo-wijvideo-timer">00:00</li>' +
								'<li class="wijmo-wijvideo-volume ui-state-default ui-corner-all">' +
									'<div class="wijmo-wijvideo-volume-container">' +
									'<div class="wijmo-wijvideo-volumeslider ui-state-default ui-corner-top"></div>' +
									 '</div>' +
									'<span class="ui-icon ui-icon-volume-on"></span>' +
								'</li>' +
								'<li class="wijmo-wijvideo-fullscreen ui-state-default ui-corner-all">' +
									'<span class="ui-icon ui-icon-arrow-4-diag"></span>' +
								'</li>' +
							'</ul>' +
						'</div>');

			$vidParent = $video.parent('.wijmo-wijvideo');
			// size the div wrapper to the height and width of the controls
			$vidParent.width($video.outerWidth())
				.height($video.outerHeight());

			$seekSlider = $vidParent.find('.wijmo-wijvideo-index-slider');
			
			//Volumn
			self._volumnOn = true;
			$volumeBtn = $vidParent.find('.wijmo-wijvideo-volume');
			
			// create the video seek slider
			interval = window.setInterval(function () {
				//replace the attr to prop
				//if ($video.attr('readyState')) {
				if (self._getVideoAttribute("readyState")) {
					window.clearInterval(interval);
					
					//note: we need to adjust the size of the video in
					//this time
					$vidParent.width($video.outerWidth())
					.height($video.outerHeight());

					//note: if the controls is invisible, it will not 
					//get the position
					$video.parent().find('.wijmo-wijvideo-controls').show();
					
					//$seekSlider = $vidParent.find('.wijmo-wijvideo-index-slider');
					pos = $vidParent.find('.wijmo-wijvideo-timer').position().left;
					$seekSlider.width(pos - $seekSlider.position().left - 15);

					$seekSlider.slider({
						value: 0,
						step: 0.01,
						max: self._getVideoAttribute("duration"),
						range: 'min',
						stop: function (e, ui) {
							seek = false;
							self._setVideoAttribute("currentTime", ui.value);
						},
						slide: function () {
							seek = true;
						}
					});
				
					self._updateTime();

					// wire up the volume
					$volumeSlider = $vidParent.find('.wijmo-wijvideo-volumeslider');
					$volumeSlider.slider({
						min: 0,
						max: 1,
						value: self._getVideoAttribute("volume"),
						step: 0.1,
						orientation: 'vertical',
						range: 'min',
						slide: function (e, ui) {
							self._setVideoAttribute("volume", ui.value);
							if (ui.value === 0) {
								self._volumnOn = false;
								$volumeBtn.find("span").removeClass("ui-icon-volume-on")
									.addClass("ui-icon-volume-off");	
							} else {
								self._volumnOn = true;
								$volumeBtn.find("span").removeClass("ui-icon-volume-off")
									.addClass("ui-icon-volume-on");	
							}
						}
					});
					
					$video.parent().find('.wijmo-wijvideo-controls')
						.css('display', 'none');
					
					self._initialToolTip();
				}
			}, 200);
			
			$video.bind("click." + self.widgetName, function () {
				self._togglePlay();
			});

			// display the bar on hover
			$('.wijmo-wijvideo').hover(function () {
				$('.wijmo-wijvideo-controls').stop(true, true).fadeIn();
			},
				function () {
					$('.wijmo-wijvideo-controls').delay(300).fadeOut();
				});

			$playbtn = $vidParent.find('.wijmo-wijvideo-play > span');
			$playbtn.click(function () {
				self._togglePlay();
			}).parent().hover(function () {
				$(this).addClass("ui-state-hover");
			}, function () {
				$(this).removeClass("ui-state-hover");
			});
			
			$vidParent.find('.wijmo-wijvideo-volume').hover(function () {
				$('.wijmo-wijvideo-volume-container')
					.stop(true, true).slideToggle();
			});
			
			$fullScreenBtn = $vidParent.find('.wijmo-wijvideo-fullscreen > span');
			
			$fullScreenBtn.click(function () {
				self._toggleFullScreen();
			}).parent().hover(function () {
				$(this).addClass("ui-state-hover");
			}, function () {
				$(this).removeClass("ui-state-hover");
			});
			
			$volumeBtn.hover(function () {
				$(this).addClass("ui-state-hover");
			}, function () {
				$(this).removeClass("ui-state-hover");
			}).click(function () {
				if (self._getVideoAttribute("readyState")) {
					self._volumnOn = !self._volumnOn;
					if (!self._volumnOn) {
						currentVolumn = $volumeSlider.slider('value');
						$volumeSlider.slider('value', 0);
						$video.attr('volume', 0);
						$volumeBtn.find("span").removeClass("ui-icon-volume-on")
							.addClass("ui-icon-volume-off");
					} else {
						$volumeSlider.slider('value', currentVolumn);
						$video.attr('volume', currentVolumn);
						$volumeBtn.find("span").removeClass("ui-icon-volume-off")
							.addClass("ui-icon-volume-on");
					}
				}
			});
			
			//move the init tooltip to interval, when the video's state
			//is ready, then init the tooltip
			//self._initialToolTip();
			
			$video.bind('play.' + self.widgetName, function () {
				$playbtn.removeClass('ui-icon ui-icon-play')
					.addClass('ui-icon ui-icon-pause');
			});

			$video.bind('pause.' + self.widgetName, function () {
				$playbtn.removeClass('ui-icon ui-icon-pause')
					.addClass('ui-icon ui-icon-play');
			});

			$video.bind('ended.' + self.widgetName, function () {
				self.pause();
			});

			$video.bind('timeupdate.' + self.widgetName, function () {
				self._updateTime();
			});

			self._videoIsControls = false;
			if (self._getVideoAttribute("controls")) {
				self._videoIsControls = true;
			}
			$video.removeAttr('controls');
		},
		
		_getVideoAttribute: function (name) {
			if (name === "") {
				return;
			}
			if ($video.attr(name) !== undefined) {
				return $video.attr(name);
			} else {
				return $video.prop(name);
			}
		},
		
		_setVideoAttribute: function (name, value) {
			if (name === "") {
				return;
			}
			if ($video.attr(name) !== undefined) {
				return $video.attr(name, value);
			} else {
				return $video.prop(name, value);
			}
		},
		
		_initialToolTip: function () {
			var self = this;
			//ToolTip-slider
			$seekSlider.wijtooltip({ mouseTrailing: true, showCallout: false, 
			position: {offset: '-60 -60'}});
			$seekSlider.bind("mousemove", function (e, ui) {
				self._changeToolTipContent(e);
			});

			//ToolTip-button
			$volumeBtn.wijtooltip({content: "Volume", showCallout: false});
			$fullScreenBtn.wijtooltip({content: "Full Screen", showCallout: false});
			
			//add class to prevent from overriding the origin css of tooltip.
			$seekSlider.wijtooltip("widget").addClass("wijmo-wijvideo");
			$volumeBtn.wijtooltip("widget").addClass("wijmo-wijvideo");
			$volumeBtn.wijtooltip("widget").addClass("wijmo-wijvideo");
		},

		_updateTime: function () {
			var self = this, dur = self._getVideoAttribute("duration"), 
			cur = self._getVideoAttribute("currentTime"),
				mm, ss, mfmt = '', sfmt = '';

			mm = this._truncate((dur - cur) / 60);
			ss = this._truncate((dur - cur) - (mm * 60));
			if (mm < 10) {
				mfmt = '0';
			}
			if (ss < 10) {
				sfmt = '0';
			}
			$vidParent.find('.wijmo-wijvideo-timer').html(mfmt + mm + ':' + sfmt + ss);
			if (!seek) {
				$seekSlider.slider('value', cur);
			}
		},

		_truncate: function (n) {
			return Math[n > 0 ? "floor" : "ceil"](n);
		},

		_togglePlay: function () {
			var self = this;
			
			if (!self._getVideoAttribute("readyState")) {
				return;
			}
			
			if (self._getVideoAttribute("paused")) {
				this.play();
			} else {
				this.pause();
			}
		},
		
		_toggleFullScreen: function () {
			var self = this,
				isPaused = self._getVideoAttribute("paused"),
				offsetWidth = 0,
				fWidth = $(window).width(), 
				fHeight = $(window).height();
			
			fullScreen = !fullScreen;
			
			if (fullScreen) {
				self._oriVidParentStyle = $vidParent.attr("style");
				self._oriWidth = $video.outerWidth();
				self._oriHeight = $video.outerHeight();
				self._oriDocOverFlow = $(document.documentElement).css("overflow");
				
				$(document.documentElement).css({
					overflow: "hidden"
				});
				
				if (!self._replacedDiv) {
					self._replacedDiv = $("<div />");
				}
				
				$vidParent.after(self._replacedDiv);
				$vidParent.addClass("wijmo-wijvideo-container-fullscreen")
					.css({
						width: fWidth,
						height: fHeight
					}).appendTo($("body"));
				
				$video.attr("width", fWidth).attr("height", fHeight);
				
				$(window).bind("resize.wijvideo", function () {
					self._fullscreenOnWindowResize();
				});
				
				//for reposition the video control
				offsetWidth = fWidth - self._oriWidth;
			} else {
				$(document.documentElement).css({
					overflow: self._oriDocOverFlow
				});
				
				//for reposition the video control
				offsetWidth = self._oriWidth - $video.width();
				
				self._replacedDiv.after($vidParent)
					.remove();
				$vidParent.removeClass("wijmo-wijvideo-container-fullscreen")
					.attr("style", "")
					.attr("style", self._oriVidParentStyle);
				
				$video.attr("width", self._oriWidth)
					.attr("height", self._oriHeight);
				
				$(window).unbind("resize.wijvideo");
			}	
			
			self._positionControls(offsetWidth);
			self._hideToolTips();
			
			if (!isPaused) {
				self.play();
			} else {
				self.pause();
			}
		},

		_fullscreenOnWindowResize: function () {
			var self = this,
				fWidth = $(window).width(), 
				fHeight = $(window).height(),
				offsetWidth = fWidth - $vidParent.width();

			$vidParent.css({
				width: fWidth,
				height: fHeight
			});
			$video.attr("width", fWidth).attr("height", fHeight);
			
			self._positionControls(offsetWidth);
		},
		
		_positionControls: function (offsetWidth) {
			var seekSlider = $vidParent
					.find('.wijmo-wijvideo-index-slider');
			
			seekSlider.width(seekSlider.width() + offsetWidth);
		},
		
		_showToolTip: function (e) {
			var self = this,
				mousePositionX = e.pageX, 
				mousePositionY = e.pageY,
				sliderOffset = $seekSlider.offset().left,
				sliderWidth = $seekSlider.width(),
				curWidth = mousePositionX - sliderOffset,
				dur = self._getVideoAttribute("duration"), 
				currentTime;
			
			currentTime = dur * (curWidth / sliderWidth);

			$seekSlider.wijtooltip("option", "content", 
				self._getToolTipContent(currentTime));
			$seekSlider.wijtooltip("showAt", 
					{ x: mousePositionX, y: mousePositionY - 10 });
		},
		
		_changeToolTipContent: function (e) {
			var self = this,
				mousePositionX = e.pageX, 
				sliderOffset = $seekSlider.offset().left,
				sliderWidth = $seekSlider.width(),
				curWidth = mousePositionX - sliderOffset,
				dur = self._getVideoAttribute("duration"),
				currentTime;
			
			currentTime = dur * (curWidth / sliderWidth);

			$seekSlider.wijtooltip("option", "content", 
				self._getToolTipContent(currentTime));
		},
		
		_hideToolTips: function () {
			$seekSlider.wijtooltip("hide");
			$volumeBtn.wijtooltip("hide");
			$fullScreenBtn.wijtooltip("hide");			
		},
		
		_getToolTipContent: function (currentTime) {
			var mm, ss, mfmt = '', sfmt = '';

			mm = parseInt(currentTime / 60, 10);
			ss = parseInt(currentTime - (mm * 60), 10);
			if (mm < 10) {
				mfmt = '0';
			}
			if (ss < 10) {
				sfmt = '0';
			}
			
			return mfmt + mm + ':' + sfmt + ss;
		},
		
		destroy: function () {
			///	<summary>
			///	Removes the wijvideo functionality completely. 
			/// This returns the element back to its pre-init state. 
			/// Code example: $("#element").wijvideo("destroy");
			///	</summary>
			
			var self = this;
			$.Widget.prototype.destroy.apply(this, arguments);
			
			//remove the controls
			$vidParent.after($video).remove();
			$video.unbind('.' + self.widgetName);
			if (self._videoIsControls) {
				self._setVideoAttribute("controls", true);
			}
		},

		play: function () {
			///	<summary>
			///	Play the video. 
			/// Code example: $("#element").wijvideo("play");
			///	</summary>
			
			$video[0].play();
		},
		
		pause: function () {
			///	<summary>
			///	Pause the video.
			/// Code example: $("#element").wijvideo("pause");
			///	</summary>
			
			$video[0].pause();
		}
	});
}(jQuery));
