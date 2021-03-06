/   օ�ü�<Y      create_object.html <!DOCTYPE html> <html> <head> <title>Create Object</title> <link rel=stylesheet type=text/css href=http://cdn.goonhub.com/css/style.css> </head> <body id=createobj> <form name=spawner action="byond://?src=/* ref src */" method=get> <input type=hidden name=src value="/* ref src */"> <input type=hidden name=action value=object_list> Type <input type=text name=filter style=width:280px onkeydown=submitFirst(event)><input type=button name=search value=Search onclick=updateSearch() style=width:70px><br> Offset: <input type=text name=offset value=x,y,z style=width:250px> A <input type=radio name=offset_type value=absolute> R <input type=radio name=offset_type value=relative checked><br> Direction: S<input type=radio name=one_direction value=2 checked> SE<input type=radio name=one_direction value=6> E<input type=radio name=one_direction value=4> NE<input type=radio name=one_direction value=5> N<input type=radio name=one_direction value=1> NW<input type=radio name=one_direction value=9> W<input type=radio name=one_direction value=8> SW<input type=radio name=one_direction value=10><br> Number: <input type=text name=object_count value=1 style=width:330px> <br><br> <div id=selector_hs> <select name=type id=object_list multiple size=20> </select> </div> <br> <input type=submit value=spawn> </form> <script language=JavaScript> var old_search = "";
		var object_list = document.spawner.object_list;
		var object_list_container = document.getElementById('selector_hs');
		var object_paths = null /* object types */;
		var objects = object_paths == null ? new Array() : object_paths.split(";");
		
		document.spawner.filter.focus();
		populateList(objects);
		
		function populateList(from_list)
		{
			var newOpts = '';
			var i;
			for (i in from_list)
			{
				newOpts += '<option value="' + from_list[i] + '">'
					+ from_list[i] + '</option>';
			}
			object_list_container.innerHTML = '<select name="type" id="object_list" multiple size="20">' + 
			newOpts + '</select>';
		}
		
		function updateSearch()
		{
			if (old_search == document.spawner.filter.value)
			{
				return false;
			}
			
			old_search = document.spawner.filter.value;
			
			
			var filtered = new Array();
			var i;
			for (i in objects)
			{
				if(objects[i].search(old_search) < 0)
				{
					continue;
				}
				
				filtered.push(objects[i]);
			}
			
			populateList(filtered);
			
			if (object_list.options.length)
				object_list.options[0].selected = 'true';
			
			return true;
		}
		
		function submitFirst(event)
		{
			if (event.keyCode == 13 || event.which == 13)
			{
				if (updateSearch())
				{
					if (event.stopPropagation) event.stopPropagation();
					else event.cancelBubble = true;

					if (event.preventDefault) event.preventDefault();
					else event.returnValue = false;
				}
			}
		} </script> </body> </html>J%   I�w��<Y    *%  pathoComp.html <!DOCTYPE html> <html> <head> <title>Pathogen Manipulator</title> <meta http-equiv=X-UA-Compatible content="IE=edge,chrome=1"> <meta http-equiv=Content-Type content="text/html; charset=UTF-8"> <script src=http://cdn.goonhub.com/js/jquery.min.js type=text/javascript></script> <!--<script src="./json2.min.js" type="text/javascript"></script>--> <script src=http://cdn.goonhub.com/js/pathology_display.js type=text/javascript></script> <script src=http://cdn.goonhub.com/js/pathoui-script.js type=text/javascript></script> <link href=http://cdn.goonhub.com/css/pathoui.css rel=stylesheet type=text/css> </head> <body> <div class=mainContent> <!--Displays information about the currently loaded pathogen--> <div id=loadedPathogen> <div class=noborder> <span class=label>DNA Load Status: </span> <div class="annunciator a-green" id=annDNALoad> LOAD </div> <div class="annunciator a-red" id=annDNANoLoad> NO LOAD </div> <div class="annunciator a-yellow" id=annDNASplice> SPLICE </div> <span class=label>Pathogen: </span> <div class="text-field tf-med" id=txtPName>G68P68</div> <div class="text-field tf-med" id=txtPType>(fungus)</div> </div> <div class=noborder> <span class=label>Slot: </span> <div class="text-field tf-narrow" id=txtExpSlot>1</div> <div class="annunciator a-yellow" id=annSlotExp>EXPOSED</div> <div class="annunciator a-green" id=annSlotSample>SAMPLE</div> <div class="button btn-small" id=btnCloseSlot>Close</div> <div class="button btn-small" id=btnEjectSample>Eject</div> </div> <div class=noborder> <span class=label>DNA Seq: </span><br> <div class="text-field tf-long" id=txtPSeq> </div> </div> </div> <!--Displays the currently selected page--> <div class=dataDisplay> <div class=dataPage id=dpManip> <h1>DNA Manipulator</h1> <div id=manipHolder> <div class="narrow-border extrapad"> <span class="label lb-long">Status:</span> <div class="annunciator a-green" id=aMutRdy>READY</div> <div class="annunciator a-yellow" id=aMutIrr>RAD</div> <div class="annunciator a-green" id=aMutAck>PASS</div> <span class="label lb-long"></span> <div class="annunciator a-red" id=aMutOpen>EXPOSED</div> <div class="annunciator a-red" id=aMutSample>SAMPLE</div> <div class="annunciator a-red" id=aMutNack>FAIL</div> </div> <table> <tr> <td><span class="label lb-long">Mutativeness:</span></td> <td><div class="button btn-tiny" data-tsk="mut=-1">-</div></td> <td><div class="text-field tf-narrow" id=txtMut></div></td> <td><div class="button btn-tiny" data-tsk="mut=1">+</div></td> </tr> <tr> <td><span class="label lb-long">Mutation Speed:</span></td> <td><div class="button btn-tiny" data-tsk="mts=-1">-</div></td> <td><div class="text-field tf-narrow" id=txtMts></div></td> <td><div class="button btn-tiny" data-tsk="mts=1">+</div></td> </tr> <tr> <td><span class="label lb-long">Advance Speed:</span></td> <td><div class="button btn-tiny" data-tsk="adv=-1">-</div></td> <td><div class="text-field tf-narrow" id=txtAdv></div></td> <td><div class="button btn-tiny" data-tsk="adv=1">+</div></td> </tr> <tr> <td><span class="label lb-long">Maliciousness:</span></td> <td><div class="button btn-tiny" data-tsk="mal=-1">-</div></td> <td><div class="text-field tf-narrow" id=txtMal></div></td> <td><div class="button btn-tiny" data-tsk="mal=1">+</div></td> </tr> <tr> <td><span class="label lb-long">Suppression Threshold:</span></td> <td><div class="button btn-tiny" data-tsk="sth=-1">-</div></td> <td><div class="text-field tf-narrow" id=txtSth></div></td> <td><div class="button btn-tiny" data-tsk="sth=1">+</div></td> </tr> </table> </div> </div> <div class=dataPage id=dpSplice1> <h1>Select splice target</h1> <span class="label lb-slong">The loaded DNA will be modified during this session.</span> <div class="noborder splice-selection"> <div class="noborder slot-holder" id=spliceSlots> </div> <div class="narrow-border button-holder" id=spliceButtons> <div class="annunciator a-red" id=annSpliceStatExp>EXPOSED</div> <div class="annunciator a-green" id=annSpliceStatSource>SOURCE</div> <div class="annunciator a-green" id=annSpliceStatTarget>TARGET</div> <hr> <div class=button id=btnSpliceBegin>Begin<br>Splice</div> <div class=button id=btnSpliceCancel>Cancel<br>Splice</div> </div> </div> </div> <div class=dataPage id=dpSplice2> <h1>Splicing Session</h1> <div class="noborder splice-selection"> <!--DATA HOLDER--> <div class=noborder id=spliceData> <div class="extrapad button-holder prediction-holder"> <span class="label lb-long">Predictive Effectiveness:</span> <div class="text-field tf-med txtPredEffect"></div> <div class="button btn-med display-known">Sequences</div> </div> <div class="extrapad splice-sequence" id=spliceTargetField> <span class="label lb-long">Target sequence:</span> <div class="text-field tf-long" id=txtSpliceTarget></div> <div class="button btn-small btn-seq-off" dir=-1>-</div> <div class="button btn-small btn-seq-off" dir=1>+</div> <span class=label>Status:</span> <div class="annunciator a-red" id=annSpliceTargetEmpty>EMPTY</div> </div> <div class="button-holder extrapad splice-controls" id=spliceActions> <span class="label lb-elong">Splice actions:</span> <div class="button btn-small" dir=-1>Before</div> <div class="button btn-small" dir=1>After</div> <div class="button btn-small" dir=0>Remove</div> </div> <div class="extrapad splice-sequence" id=spliceSourceField> <span class="label lb-long">Source sequence:</span> <div class="text-field tf-long" id=txtSpliceSource></div> <div class="button btn-small btn-seq-off" dir=-1>-</div> <div class="button btn-small btn-seq-off" dir=1>+</div> <span class=label>Status:</span> <div class="annunciator a-red" id=annSpliceSourceEmpty>EMPTY</div> </div> </div> <!--FINALIZING BUTTONS--> <div class="button-holder extrapad" id=spliceFinalButtons> <span class="label lb-med">Splice status:</span> <div class="annunciator a-green" id=annSpliceSuccess>SUCCESS</div> <div class="annunciator a-red" id=annSpliceFail>FAIL</div> <span class=label>Prediction:</span> <div class="annunciator a-green" id=annPredSuccess>SUCCESS</div> <div class="annunciator a-yellow" id=annPredUnk>UNKNOWN</div> <div class="annunciator a-red" id=annPredFail>FAIL</div> <hr> <div class=button id=btnSpliceFinish>Finish Splicing</div> </div> </div> </div> <div class=dataPage id=dpTester> <h1>DNA Stability Analyzer</h1> <div class=noborder id=analyzerHolder> <!--SHOWING PREDICTIVE EFFECTIVENESS--> <div class="narrow-border extrapad button-holder" id=predictionHolder> <span class="label lb-long">Predictive Effectiveness:</span> <div class="text-field tf-med txtPredEffect"></div> <div class="button btn-med display-known">Sequences</div> </div> <!--HOLDING BOTH ANALYSIS BUFFERS (current / previous) --> <div class="noborder extramargin"> <div class="narrow-border analysis-buffer extrapad" id=currAnalysis> <span class="label lb-long block">Current analysis:</span> <div class="text-field tf-enarrow" id=currAnalysis0></div> <div class="text-field tf-enarrow" id=currAnalysis1></div> <div class="text-field tf-enarrow" id=currAnalysis2></div> <div class="text-field tf-enarrow" id=currAnalysis3></div> <div class="text-field tf-enarrow" id=currAnalysis4></div> <div class="button btn-tinyish" id=btnClrAnalysisCurr>CLR</div> </div> <div class="narrow-border analysis-buffer extrapad" id=prevAnalysis> <span class="label lb-long block">Previous analysis:</span> <div class="text-field tf-enarrow" id=prevAnalysis0></div> <div class="text-field tf-enarrow" id=prevAnalysis1></div> <div class="text-field tf-enarrow" id=prevAnalysis2></div> <div class="text-field tf-enarrow" id=prevAnalysis3></div> <div class="text-field tf-enarrow" id=prevAnalysis4></div> </div> </div> <div class="noborder extramargin"> <div class="extrapad button-holder" id=analyzeComponents> </div> <div class="narrow-border extrapad" id=analyzeResults> <span class=label>Stable:</span> <div class="annunciator a-green" id=annStableYes>YES</div> <div class="annunciator a-red" id=annStableNo>NO</div> <span class=label>Transient:</span> <div class="annunciator a-green" id=annTransYes>YES</div> <div class="annunciator a-red" id=annTransNo>NO</div> <hr> <span class=label>Error:</span> <div class="annunciator a-red" id=annErrBuffer>BUFFER</div> <div class="annunciator a-red" id=annErrNack>NACK</div> <span class=label></span> <div class="annunciator a-yellow" id=annErrSample>SAMPLE</div> <div class="annunciator a-yellow" id=annErrData>T. DATA</div> </div> </div> <div class="button btn-long" id=btnAnalysisLoad>Load Sample &amp; Clear Buffer</div> <div class="button btn-long" id=btnAnalysisDoTest>Test DNA</div> </div> </div> <div class=dataPage id=dpLoadSave> <h1>Load / Save DNA</h1> <div class="noborder slot-holder" id=dnaSlotHolder> </div> </div> <div class=dataPage id=dpWelcome> <h1>Welcome to the Path-o-matic 2000</h1> <span>The leading market solution for pathology research.</span> <span>This device is capable of the following:</span> <ul> <li>DNA Sequence Verification</li> <li>DNA Sequence Splicing</li> <li>DNA Trait Segment Manipulation</li> <li>Predictive Stability Analysis</li> <li>Pathogen Sample Identification</li> </ul> </div> </div> <!--The main menu, used for scrolling through the pages--> <div id=mainMenu> <div class=button id=btnRetMain>Main Screen</div> <div class=button id=btnManip>Manipulate</div> <div class=button id=btnSplice>Splice</div> <div class=button id=btnTester>DNA Analyzer</div> <div class=button id=btnLoadSave>Load / Save DNA</div> <div class="annunciator a-yellow" id=annSynch>SYNCH</div> </div> </div> </body> </html>:   �����<Y      tooltip.html <!DOCTYPE html> <html> <head> <title>Tooltip</title> <meta http-equiv=X-UA-Compatible content="IE=edge,chrome=1"> <meta http-equiv=Content-Type content="text/html; charset=UTF-8"> <link rel=stylesheet type=text/css href=http://cdn.goonhub.com/css/font-awesome.css> <link rel=stylesheet type=text/css href=http://cdn.goonhub.com/css/tooltip.css> </head> <body> <div id=wrap class=wrap> <div id=content class=content></div> <a href=# class=close-tip style="display: none"><i class=icon-remove></i></a> </div> <script type=text/javascript src=http://cdn.goonhub.com/js/jquery.min.js></script> <script type=text/javascript src=http://cdn.goonhub.com/js/jquery.waitForImages.js></script> <script type=text/javascript src=http://cdn.goonhub.com/js/errorHandler.js></script> <script type=text/javascript src=http://cdn.goonhub.com/js/animatePopup.js></script> <script type=text/javascript> var tooltipRef = 'TOOLTIPREFPLACE';
		var tooltipDebug = false; </script> <script type=text/javascript src=http://cdn.goonhub.com/js/tooltip.js></script> </body> </html>�   �"ů<Y    �  browserOutput.html <!DOCTYPE html> <html> <head> <title>Chat</title> <meta http-equiv=X-UA-Compatible content="IE=edge,chrome=1"> <meta http-equiv=Content-Type content="text/html; charset=UTF-8"> <link rel=stylesheet type=text/css href=http://cdn.goonhub.com/css/font-awesome.css> <link rel=stylesheet type=text/css href=http://cdn.goonhub.com/css/browserOutput.css> <script type=text/javascript src=http://cdn.goonhub.com/js/jquery.min.js></script> <!-- <script type="text/javascript" src="http://cdn.goonhub.com/js/array.generics.min.js"></script> --> </head> <body> <div id=loading> <i class="icon-spinner icon-2x"></i> <div> Loading...<br><br> If this takes longer than 30 seconds, it will automatically reload a maximum of 5 times.<br> If it STILL doesn't work, please post a report here: <a href="https://forum.ss13.co/viewforum.php?f=7">https://forum.ss13.co/viewforum.php?f=7</a> </div> </div> <div id=messages> </div> <div id=userBar style="display: none"> <div id=ping> <i class=icon-circle id=pingDot></i> <span class=ms id=pingMs>--ms</span> </div> <div id=options> <a href=# class=toggle id=toggleOptions title=Options><i class=icon-cog></i></a> <div class=sub id=subOptions> <a href=# class=decreaseFont id=decreaseFont><span>Decrease font size</span> <i class=icon-font>-</i></a> <a href=# class=increaseFont id=increaseFont><span>Increase font size</span> <i class=icon-font>+</i></a> <a href=# class=chooseFont id=chooseFont>Change font <i class=icon-font></i></a> <a href=# class=togglePing id=togglePing><span>Toggle ping display</span> <i class=icon-circle></i></a> <a href=# class=highlightTerm id=highlightTerm><span>Highlight string</span> <i class=icon-tag></i></a> <a href=# class=saveLog id=saveLog><span>Save chat log</span> <i class=icon-save></i></a> <a href=# class=clearMessages id=clearMessages><span>Clear all messages</span> <i class=icon-eraser></i></a> </div> </div> </div> <audio id=play-music class=hidden autoplay></audio> <script type=text/javascript src=http://cdn.goonhub.com/js/errorHandler.js></script> <!-- <script type="text/javascript" src="http://cdn.goonhub.com/js/anchorme.js"></script> --> <script type=text/javascript src=http://cdn.goonhub.com/js/browserOutput.js></script> </body> </html>*    ǡpƯ<Y       parser.html Go away nerd.�   P�A˯<Y    �  changelog.html <style type=text/css> .postcard {display: block; margin: 10px auto; width: 300px;}
	h1 {font-size: 2.5em; padding: 0 10px; margin: 0; color: #115FD5;}
	h1 a {display: block; float: right;}
	.links {list-style-type: none; margin: 15px 5px; padding: 0; border: 1px solid #ccc; color: #333;}
	.links li {float: left; width: 50%; text-align: center; background: #f9f9f9; padding: 10px 0; position: relative;}
	.links li span {position: absolute; top: 0; right: 0; bottom: 0; width: 1px; background: #ccc;}

	.log {list-style-type: none; padding: 0; background: #f9f9f9; margin: 20px 5px; border: 1px solid #ccc; font-size: 1em; color: #333;}
	.log li {padding: 5px 5px 5px 20px; border-top: 1px solid #ccc; line-height: 1.4}
	.log li.title {background: #efefef; font-size: 1.7em; color: #115FD5; padding: 10px 10px; border-top: 0;}
	.log li.date {background: #f1f1f1; font-size: 1.1em; font-weight: bold; padding: 8px 5px; border-bottom: 2px solid #bbb;}
	.log li.admin {font-size: 1.2em; padding: 5px 5px 5px 10px;}
	.log li.admin span {color: #2A76E7;}

	h3 {padding: 0 10px; margin: 0; color: #115FD5;}
	.team, .lic {padding: 10px; margin: 0; line-height: 1.4;}
	.lic {font-size: 0.9em;} </style> <!-- HTML GOES HERE -->�    O��̯<Y    �   burtenmuffigur.txt general
	key = "Burten Muffigur"
	ckey = "burtenmuffigur"
	gender = "male"
	joined = "2015-07-06"
	desc = "This guy lol"
	online = 1
�   ��]U{�<Y    e  traitorTips.html <link rel=stylesheet type=text/css href=http://cdn.goonhub.com/css/style.css> <div class=traitor-tips> <h1 class=center>You are a traitor!</h1> <img src=http://cdn.goonhub.com/images/antagTips/traitor-image.png class=center> <p>1. The Syndicate has provided you with a disguised uplink. It can either be your <em>PDA</em> or <em>headset</em>.</p> <p>2. The details and your objectives will always be stored in your notes. To access them, use the <em>Notes</em> verb.</p> <p> 2. To unlock a <em>PDA</em>:<br> <span class="small indent"> 1. Put your PDA in an empty hand and click on it.<br> 2. Under 'General Functions', select 'Messenger'.<br> 3. Click 'Set Ringtone'.<br> 4. Enter the password. </span> </p> <p> 3. To unlock a <em>headset</em>:<br> <span class="small indent"> 1. Put your headset in an empty hand and click on it.<br> 2. Dial in the frequency assigned to you.<br> 3. Press the 'Lock' button after you're done buying the items.<br> 4. It will now function as a regular headset again. </span> </p> <p>4. For more information, please consult <a href=http://wiki.ss13.co/Syndicate_Items>the wiki</a>.</p> </div>�    ����v=Y    h   lordragu.txt general
	key = "Lord Ragu"
	ckey = "lordragu"
	gender = "male"
	joined = "2013-03-06"
	online = 1
y    ����΀=Y    [   lordragu.txt general
	key = "Lord Ragu"
	ckey = "lordragu"
	gender = "male"
	joined = "2013-03-06"
6   �d���AY    $    DDMI   �  snackcake @���T  �B 6   ��B�AY    $    DDMI   �  snackcake @���ۡ(�B 6   v�ϟ�AY    $    DDMI   �  snackcake @����� �B 6   >��Q�AY    $    DDMI   �  snackcake @���� f�B 6   h�ۯ�AY    $    DDMI   �  snackcake @���3� �B 6   v����AY    $    DDMI   �  snackcake @���  ��B 4   3\O��AY    "    DDMI   )	  wanted-unknown @���3   �B��AY    !    DDMI   T	  precursor-2fx @���6   xL��AY    $    DDMI   �   seeds-ovl @���   �B 6   r}��AY    $    DDMI   �   seeds-ovl @�������B '   ��Y	�AY        DDMI   �  ����B �   �#K
�AY    �    DDMI�   X   body_m @���   �B w   No Underwear @�������BBd  N   blank @   BBJ  �?  �?  �?  �?  �?  �?  �?  �?  �?  �?  �?  �?V  static @���B3   "L��
�AY    !    DDMI   �  ice100 @���A�B 3   <
�AY    !    DDMI   �  ice100 @�������B 3   ۀ�r
�AY    !    DDMI   �  ice100 @�����3�B 3   �>ϼ
�AY    !    DDMI   �  ice100 @�������B 3   ƴ��
�AY    !    DDMI   �  ice100 @�������B 3   Y���
�AY    !    DDMI   �  ice100 @������B 3   ��]�
�AY    !    DDMI   �  ice100 @���x ��B 3   a�Q
�AY    !    DDMI   �  ice100 @�������B 3   yJ��
�AY    !    DDMI   �  ice100 @�������B 3   ե��
�AY    !    DDMI   �  ice100 @�������B 3   ��j
�AY    !    DDMI   �  ice100 @�������B 3   L��C
�AY    !    DDMI   �  ice100 @���'�B 1   gx��AY        DDMI   �  butt @���   �B �   wD��AY    �    DDMI}   		  head @���   �B Y   eyes @����BBY   short @����BBY   tramp @����BBY   none @����BBM   (��F�AY    ;    DDMI3   �  chest_m @���   �B �  chest_blood @���BE    .���AY    3    {"error":"You don't have access to this resource."}�   O9��AY    �    DDMI|   		  head @���   �B Y   eyes @����BBY   short @����BBY   none @����BBY   none @����BB3   x�a�AY    !    DDMI   T	  precursor-5fx @����   �H���AY    �    DDMI{   		  head @���   �B Y   eyes @����BBY   pomp @�����F�BBY   none @����BBY   none @����BB,   2�^�AY        DDMI   		  monkey @����   �����AY    �    DDMI�   X   body_m @���   �B Y   eyes @����BY   short @����BBY   none @����BBY   none @����BBw   none @�������BBB-   �R�#�AY        DDMI   n   preview @����   Uˀ��AY    �  lordragu.txt general
	key = "Lord Ragu"
	ckey = "lordragu"
	gender = "male"
	joined = "2013-03-06"
	online = 1
world/1
	name = "Space Station 13"
	path = "Exadv1.SpaceStation13"
	hub_url = "http://www.byond.com/games/Exadv1/SpaceStation13"
	icon = "http://www.byond.com/games/hubicon/8266.png"
	small_icon = "http://www.byond.com/games/hubicon/8266_s.png"
	banner = "http://www.byond.com/games/banners/8266.png"
	status = "<b>Paradise Station</b> &#8212; <b>NSS Cyberiad</b> (<a href=\"http://nanotrasen.se/phpBB3/index.php\">Custom ParaCode</a>)<br>The Perfect Mix of RP & Action<br>: secret, no respawn, AI allowed, ~110 players"
	players = 110
�   �2���AY    �    DDMI�   X   body_m @���%%%�BY   eyes @����BY   fullbeard @����BBY   pomp @����BBY   none @����BBw   none @�������BBB�  �����AY    �   �PNG

   IHDR   �   �   ~M(   PLTE�����̙��fff���333   �&�B   tRNS @��f   pzTXtDescription  x�SVpru��Sp���*K-*���S�U0�3��,�L)� r���83R3�3J ��ĒT SI��3%�����3�(17�6���$V��:Pȥ����� �JV��]�  �IDATh���r��@��Ylgdm��:��˼;���;U�t�H��,ǻ��i@j���[��?bY�y�t.�E_1N�^-?��Z��������Vيe��c��=�f(��¶����5�*���"���g_���_�l9��� �$=v�����i��Y S�	.�E���C�l�e!Ӏ�k���m��y�J�r>�X��쒀ק�-�ڱ[���0M��c�C�����r<�[�q�h�4��ax�4 �z��l1Ͽo�ov��ZZ�dv������^K��[q&�%�H�ax��4 ��D&�{;�nw9i�۱PƇ|���X���֎[�Ҿ�zC�Ȥ>q��vN�Sv+�2guL���"���#]�CS����˪����c�L���u�%� �*MDʃ<�sV������xT�[�M��`����OZ�mg��4][XH�򀶥��c���lOO� ��<��NJrߑG�g�N�*�bײ*�e�t�S�ӡ��^X�B�N�9�-+���,��A"-:�lr���a�-)����MA(KsnF�r4fݰL^ƒ?Љ]d�@�q1t�T��ӗ���s5�6ͨI��K��c���_�s��.�1����i6�!v�����Px�w�8�C���!w�vyU�������b��������˾�,+fo���T�)�;ۘ"����v�N0-���o�.F���3<�}q.+/o�.A���f�/uf����12��6[ێOC��x�wp��i@�u��j�W������Ӏȷ���Miy����~'��D^mkx(uic��߉���Ѩ߳4��s.o�N$�$ �x0�U�����7~!���R�}��S��o��z�YOp���tt��7~�&�=VW�\��]lg�~v�i�Qg� �wlm(p�����N��;�gN������x�w��Tn�B3�U�py�wQ��Va;�85*�[�sK����#�������~9KC3L^���7~�)s�������x����:�K�~QI�m���|������{M�G|������'|���~d=����XM&�����r�����6�9���T�3s�Î�W�	�ċ�H�l!���l��eP��0T�:�br�'�{W�����%�������C��^�D�����Ae���z�1��/����5��������1�T`��n@�LTf����aL���;�yh�~.6*=�eGv˾��n@�]Q��4��=�5�;o���N>�e:�M[C��t�H������EM[i�� ��\�߽�8�}�^���="ӑ�~GO )N��OQ[���.�/��x��'�ڨ `���i^���إY]XDC�0k�a��e:�`̎�ɩ���c�y:X�g��ܝ3(.���:�P�����X~����*dl�E�:�&K'Ò-�eٍ6�0M:/��v���i���L��g�n��b�5��oYN���2�Aη�x�`�Y>H�Z����pf/��Ɵ�w�?�ߥ�:��]���gV�����W4����(�M`���7~����;6!���}����o����'ˎw�n�QC��C�}�e������"�� �(hg���S���ִ��E�L�Gf)�߭�����U���b�L�Gf��ր��T�f��.� ���s���!)�j��6ջ��������J���a��������㑝?��<t�F���:(�a�wҨj\Ң�0���IF.;~��}�L�a��~v��;ٛ�7�,ƁL��p����ys�J�>�rd����n�q��aC�eP������fr4V�`�"ǅ���=F��D�O�
��k��Q�w0�ӎ^�knL�Ńr\F�9d������F�����8Ҁd�0�FG�k�^��C>~`/x|R2u>��ON���̦ǌ��!��jH3��MC��n�ݘ>{���aۏ���~R��9�/�������Y�������|�7��    IEND�B`��  \U�~��AY    �   �PNG

   IHDR   �   �   ~M(   PLTE������������333fff   Ұ�   tRNS @��f   pzTXtDescription  x�SVpru��Sp���*K-*���S�U0�3��,�L)� r���83R3�3J ��ĒT SI��3%�����3�(17�6���$V��:Pȥ����� �JV��]�  �IDATh����v�:@�0Yazem����!k#���uz���*�T�H>�L{w%S ��@���S���n�9�۟q;���QןpS��v��?�*�Gꤻ���t)i@i����Z�,��,����Dټ��j�}~������/�K�}�Y��۝˴=�
����6��ҍeۼ-?`�BB?M��������hUyY��4 � ��4f��֪�>	2�$��LMg�|L���묲Ӹ��� Ӏ����yy:��r�t�tS�{�2��ojU������F��H�ahAf�<�U��ԍ�H�t�Nj�CE���;�薩|3��h4:�J{
�ˉ����,)QJ�Y�d��I}✤����f.O��w}l���"���cS��T��ܟ�:����c�L���e%� �.m|&�p�箅�0�����ٰJ���5�"�>�U$�j`	H�� �FP�4�ޗl����r���h_�$O[�H���XXlF�"@�=��m�ה�z,�w�����m�rڽ�U`��|m�*�-lC��P�`����PX�MI�q�l��2���.���3��mC��fښ]�e��U�)5$����ױd����s��W�0�~���6k^��#֊��5����M^����G,O�C���=�H��{��~����ˋN� ����?�;�f�W~������C��;��k�7j�U�W~'��%l��`[�s"g+^�]�L"/gx��^�^^�]�L"�3�[����+�	2��t+5�/yU�x�wp��i@���Z���T���k��L"�#����([��N|2���V�T�R%��k�	2���Լ6m3�s.��ND�$ �$���)���~#���e�թҧ���~��L��.'8$V�&����f#ޟ�.��.Q�K	5��h�C���;�78�Y��l� ��ꙓ���뜩 ��.I���M�h��.X.��.�۪�m��:� ��N֬��K|�Vp]^��/'`ii��-nd�����lj#�S;��&/�w��Gv	�o*鉚�o�w/���#�����#ߓJ}����T���}�b���#ߋ����G������)��$C���7U�rA��t�{}�|\�ߝf7���1�Pˉ�Ak5�� C5`�S(&w����G�pQ���Y ���;ڀ��C�,/���B"���w�yI��V�>볏���x�~G��;��ß筏a*���w�y�Fi]������w�y	h�~v*.=�iG;v�>��6 �W5�L��G.�Λ(����e���4ެ���
0�:���q����4��è2��x(W�wg'.���v1������� R�������]�|����}O���,!�1�>
Cv�i��-�"nB�`x�`��l�k�a2;�'��7����h� ��?��swΠ�`�?� C�r|2��`������|�6�.��ulM�N�%ۀ�r�� �2�J��yJ�F6��f{?�(w34�G�A�J����˸.7I��*�Խ����﹗1��^����w�������MY��W~���J��ߵ����]�K.wV���k߫�{�^�^���@��W~�'���+�!^�����!������V�O7�.�|�`��m��eLQD����-�شϣs/����RD�[N�v���Y��e�A��#���wK��d�Ӵ�w�A�YB�m@���J����e���xd��<������<����d��d���1�y�sP���L�!�;iu�vm5y_� ��\v�.�קv����d�y�a��df���y'0��.�mߛ�����>����x�g�p�}T�M%�A}���N?������� �9.TOgސi��k�,�+>�S��(`v���X<i�e4ߐC�=Cb��`�|~�厎� (A�� �lt����0wRzɑڿ� �:���'`��6���
?C@g��6g�v��qөm�>{'O��a����~R��v��q��{�]�w'�%.8*�o�    IEND�B`�6   ?wp���AY    $    DDMI   �   seeds-ovl @��� � �B 1   ��L��AY        DDMI   �  butt @���%%%�B�   ӿ���AY    �    DDMI�   		  head @���%%%�BY   eyes @����BBY   fullbeard @����BBY   pomp @����BBY   none @����BBM   �c\��AY    ;    DDMI3   �  chest_m @���%%%�B�  chest_blood @���B�  B�M���AY    s   �PNG

   IHDR           D���   9PLTELiqjjj������qrr   555������:;:???������������'''000���)))�0��   tRNS @��f   dzTXtDescription  x�SVpru��Sp���*K-*���S�U0�3��,�L)� r���83R3�3J ��ĒT SI��3%���4��L+J�M���\�\�& ��}��C   xIDAT8���� D�Y���m����^��\�1MSz�Y����L�2O"ĀjYK-����(1��G�wcBt���f�j ]�n y�5ohƄ���+��^v�N�c?�CbB�7l��'�!���    IEND�B`�}  �%Ei��AY    k   �PNG

   IHDR           �Tg�   $PLTELiq|||   A@@QQQUUUnnnYYYEEEe�Tt   tRNS @��f   dzTXtDescription  x�SVpru��Sp���*K-*���S�U0�3��,�L)� r���83R3�3J ��ĒT SI��3%���4��L+J�M���\�\�& ��}��C   �IDAT(�c`@ (���(��3*�20�	�X�J�����-�&�􎎲4�!ji��iI�@�*0s�4$�e3� a7D �Ztf�����(Z@�"����eT��a������00��@ �,��[�    IEND�B`�H  �O����AY    6   �PNG

   IHDR           �Tg�   !PLTELiq&%%ooo���332���������((( �����   tRNS @��f   dzTXtDescription  x�SVpru��Sp���*K-*���S�U0�3��,�L)� r���83R3�3J ��ĒT SI��3%���4��L+J�M���\�\�& ��}��C   SIDAT(�c`L�QM@�D U�q�#�@ji#�@��D�+��l�n�
ecFAd%@��nc
�� #d=h
9  w 	n�    IEND�B`��  ��l:��AY    |   �PNG

   IHDR           D���   6PLTELiq866   55&��u��cxwZ�~`@@/{z[�����l�##p�Z�~�g}�fj~V���   tRNS @��f   dzTXtDescription  x�SVpru��Sp���*K-*���S�U0�3��,�L)� r���83R3�3J ��ĒT SI��3%���4��L+J�M���\�\�& ��}��C   �IDAT8����0 ]�	Ed���N���)ć��{�r�e����G�@�8��1?�i0 � �8��S��C�@PUU�-�L��
ي^ؐ(�C�������dO_�?�X��O�oQ�z���s�3���y����"    IEND�B`�}  v��B��AY    k   �PNG

   IHDR           �Tg�   PLTELiq<<<www���FFF[[[666{yy9   tRNS @��f   dzTXtDescription  x�SVpru��Sp���*K-*���S�U0�3��,�L)� r���83R3�3J ��ĒT SI��3%���4��L+J�M���\�\�& ��}��C   �IDAT(�͐1�0EӅ��\����ș��}���i��`e�m��;��?+c�Ô�K	*s�$��8s-����!.�$�*]�ZE]�̲�PR����B|˙�,. ���Ҿ)���M��@ta6��["7�w����~���'�^���    IEND�B`�,   �&���AY        DDMI   b  id_civ @  ��  \+e��AY    �   �PNG

   IHDR           D���   �PLTELiqddd���������������������;;;:::���  Tk Ul���<<<������������ Sj��������� Ri .;777������������ -:������������������������ <M =N��� �ԃ����� �� K` Qg��������� ;K������e�՞   tRNS @��f   dzTXtDescription  x�SVpru��Sp���*K-*���S�U0�3��,�L)� r���83R3�3J ��ĒT SI��3%���4��L+J�M���\�\�& ��}��C  DIDAT8�ՒoS�@�e��L�����a���@A��C�i㐢�l��}������j�:���`�
�,V9���ׯ!U�nb�v+��5nL�l�Z�}b`�S�L�gڍ�C#��u9瓉�iߑ��,���9J~��p,]_�<p�y^{�3��0,.���� X�0�U�nH�`���
�{4m-�xg`����u0���{{X�x���a�s'�L����2�<��y��L�8ŀ� N�Y�)����i*��L�~��`�*�ap��'f0���mۨ��P(p	8�H�(2�j%�U����rD�t0.�?�'~�$�(�T    IEND�B`�R  i�o�AY    @   �PNG

   IHDR           szz�   izTXtDescription  x�%ǽ
� ����G�K(�� h�P�J�~��9�ލ����Xj~nH��H�ˡ%H,3��ZOm�EHpN,�R!1;��b��v
�����rFB   �IDATX�c��,dH�4���:`��`!G���kl�7���4}��k+��&���ϳ��H���|<�[�_��%G�ydE���N6�Wt��=m����G����u��F@rIxy�
��ɵ�(u��F  �� �j�    IEND�B`�*   z�����AY        DDMI     chef @  �~  <��S��AY    l   �PNG

   IHDR           D���   3PLTELiq���������jjj������������\\\GGGLKLfff~~~���ddettt��B   tRNS @��f   dzTXtDescription  x�SVpru��Sp���*K-*���S�U0�3��,�L)� r���83R3�3J ��ĒT SI��3%���4��L+J�M���\�\�& ��}��C   wIDAT8��α�0�z"V����R�sq��ҁ �?�dUɤ_�IT(XDz�b٦���" �f3�p��=���	� 1x�+��`�릻nk]����)Pu�Q�ye�|�	­��\�    IEND�B`�*   �=0-��AY        DDMI   N  chef @  ��  �b����AY    {   �PNG

   IHDR           D���   0PLTELiqhhh�$/jjj���������������������666777������~~~��+f   tRNS @��f   dzTXtDescription  x�SVpru��Sp���*K-*���S�U0�3��,�L)� r���83R3�3J ��ĒT SI��3%���4��L+J�M���\�\�& ��}��C   �IDAT8��Q�0�m�����V�&
7p?Z��L�i���,⧈f= #XbBABe\!�W.p��  g�~|�X��e�JVJ5�p�'�k�.��֢=�i��p2�N�%���fH�����O2�ffݺ_=��K���ly%    IEND�B`�