GAKU Engine [学園陣]
====================
Genshin Academic Karte Unification Engine
=========================================

GAKU Engine is a student/assignment focused student and school management system.

What does the name mean?
------------------------
The kanji for "learning" is 学[gaku]. So literally GAKU Engine alone means "Learning Engine". The full Japanese name further uses "ateji" to make the name into 学園陣, which is broken down into 学園[gakuen] "academic" and 陣[jin] "encampment/battle formation". Either way it's always read the same, so take your pick of the meaning: "Learning Engine" or "Academic Encampment".  

For the English we also chose to treat GAKU as an acronym, which can be seen above. You know, because confusing acronyms are radical to the max.

What does it do?
----------------
It allows for full student management, grading etc. It's bascally what all student grading tools are but it's unique in that:

* It's completely Open Source, licensed under the GPL3. (See note #1)
* It only uses Free Open Source components and does not rely on a licensed back end - so you don't need to worry about the BSA suing you. (See note #2)
* It's Rails based, so it's easily extendable and runs on everything.
* It does not require a special client to use. Any web browser will do. Special clients can be developed, and one for students will eventually be created [for use on smart phones].
* It will feature a full set of "social" interfaces for students. Students will be able to check their grades, assignments, download notes and printouts, communicate with teachers and staff and share links and information. These features can be enabled or disabled and can be easily regulated by staff.
* It is multi-locale. Generated reports and paperwork will be formatted appropriately for your schools country of operation (if paperwork for your contry is not available yet please file an issue and we will see about adding it).

Notes
-----
1. Schools can use it for free - though ideally we want schools to hire developers on maintenance contracts so the software can be improved and schools don't need to worry about the system being poorly maintained by untrained internal staff.
2. Part of the reason GAKU Engine was created was to eliminate dependence on commercial licenses from certain companies.
	- These licenses are expensive, and many school management systems are built on and rely on them. 
	- The problem is some companies have created organizations (specifically the BSA) that actively go after schools for license infringement.
	- Schools are particularly easy targets as they often have a lot of computers and very rarely have license management schemes. 
	- Don't take this lightly - a school we spoke to was strong armed into paying the equivilent of 6 teachers simply because they hadn't kept complete records.
	- The school we spoke to appears to have made it off lightly. Other accounts from schools reveal much worse. Reguardless of weather or not you choose to use GAKU Engine we recommend you take these factors into consideration and avoid all vendors associated with organizations like the BSA.
	- Far more than that just your back end systems we recommend switching to OSS software on your workstations, such as LibreOffice, GIMP, InkScape, GNU/Linux (we love Ubuntu and Debian), etc.

Development Status
------------------
Development continuing is contigent upon receiving proper initial funding. Currently what you see here is a very rought demo which is being refined as time permits. Failure to acquire funds will not end the project but may inhibit its progress.  
If you would like to participate in development or if you are a school and would like to see GAKU Engine developed (we will offer services for free to everyone who funds development) plese contact Genshin Souzou K.K. at info@genshin.org

Full Naming History
-------------------
GAKU Engine is primarily being developed by the Genshin Souzou organization in Japan. It is also being developed in Ruby/Rails, in which using Japanese names is a common practice. So we chose to use the character for "learning", which is 学 - read "gaku".  
But "gaku" alone in Japanese isn't a very good name for a software project. So we added "Engine" because it's also a common Rails naming construct and because adding the word "Engine" to something makes it sound all powerful and cool.  
So now the name was literally "Learning Engine". We decided to take that one step further and create a fully Japanized name using a practice called "ateji". It just so happens the word for "academic" is 学園[gakuen]. Now all we had left is "jin", which we chose the character 陣, which means "encampment" (like a strategic or battle formation).  
To further make things all cool and confusing we made GAKU into an acronym in English. The debate continues as to weather G should remain "Genshin" or should be changed to GNU, but for now just assume the G in Genshin to be synonymous with GNU.  
