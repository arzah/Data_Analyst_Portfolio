create database Discworld;
use discworld;

create table ART_STYLE (
	Art_Style_ID smallint unsigned not null auto_increment,
	Whole BOOLEAN,
	Part BOOLEAN,
	Illustrated BOOLEAN,
	primary key (Art_Style_ID)
	);

create table STORY (
	Title varchar(50),
	Copyright year,
	Blurb mediumtext,
	SeriesNumber tinyint,
	Subseries enum("Rincewind", "Witches", "Death", "Standalone", "City Watch", "Tiffany Aching", "Industrial Revolution"),
	primary key (Title)
	);
 
 create table COVER_ARTIST (
	Cover_Artist_ID smallint unsigned not null auto_increment PRIMARY KEY,
	ArtFirstName varchar(25),
	ArtLastName varchar(25)
);

create table PUBLISHER (
	PUBLISHER_ID smallint unsigned not null auto_increment PRIMARY KEY,
	PublisherName varchar(50)
    );

create table SIZE (
	Size_ID smallint unsigned not null auto_increment PRIMARY KEY,
	Height double,
	Width double,
	Pages smallint
);

create table PUBLISHER_LOCATION (
	PUBLISHER_LOCATION_ID smallint unsigned not null auto_increment PRIMARY KEY,
	PubCountry varchar(20),
	PubCity varchar(20)
    );

CREATE TABLE NARRATOR (
    NARRATOR_ID smallint unsigned not null auto_increment PRIMARY KEY,
	NarFirstName VARCHAR(25),
    NarLastName VARCHAR(25)
);

create table PUBLISHER_IMPRINT (
    PUBLISHER_IMPRINT_ID smallint unsigned not null auto_increment PRIMARY KEY,
    PUBLISHER_ID smallint unsigned not null, 
		FOREIGN KEY (PUBLISHER_ID) REFERENCES PUBLISHER(PUBLISHER_ID),
	ImprintName varchar(50)
);

create table COVER_ART (
	Cover_Art_ID smallint unsigned not null auto_increment PRIMARY KEY,
	Cover_Artist_ID smallint unsigned not null,
		foreign key (Cover_Artist_ID) references COVER_ARTIST (Cover_Artist_ID),
	Story_ID varchar(50),
		foreign key (Story_ID) references STORY (Title),
	Art_Style_ID smallint unsigned not null,
		foreign key (Art_Style_ID) references ART_STYLE (Art_Style_ID),
	Cover longblob
);

create table DIMENSIONS (
	Dimensions_ID smallint unsigned not null auto_increment PRIMARY KEY,
	Size_ID smallint unsigned not null,
		foreign key (Size_ID) references SIZE (Size_ID),
	BookFormat enum("Hardcover", "Paperback", "Ebook")
);

create table PUBLICATION (
    PUBLICATION_ID smallint unsigned not null auto_increment PRIMARY KEY,
    PUBLISHER_IMPRINT_ID smallint unsigned not null, 
		FOREIGN KEY (PUBLISHER_IMPRINT_ID) REFERENCES PUBLISHER_IMPRINT(PUBLISHER_IMPRINT_ID),
	PUBLISHER_LOCATION_ID smallint unsigned not null, 
		FOREIGN KEY (PUBLISHER_LOCATION_ID) REFERENCES PUBLISHER_LOCATION(PUBLISHER_LOCATION_ID)
); 

CREATE TABLE AUDIO_BOOK (
    AUDIO_BOOK_ID smallint unsigned not null auto_increment PRIMARY KEY,
    STORY_ID VARCHAR(50), 
		FOREIGN KEY (STORY_ID) REFERENCES STORY(Title),
    COVER_ART_ID smallint unsigned not null, 
		FOREIGN KEY (COVER_ART_ID) REFERENCES COVER_ART(Cover_Art_ID),
    PUBLICATION_ID smallint unsigned not null,
		FOREIGN KEY (PUBLICATION_ID) REFERENCES PUBLICATION(PUBLICATION_ID),
	ReleaseYear YEAR,
    RecordingLength TIME,
    Abridged BOOL    
);

create table EDITION (
	Edition_ID smallint unsigned not null auto_increment PRIMARY KEY,
	Cover_Art_ID smallint unsigned not null,
		foreign key (Cover_Art_ID) references COVER_ART (Cover_Art_ID),
	Publication_ID smallint unsigned not null,
		foreign key (Publication_ID) references PUBLICATION (Publication_ID),
	Story_ID varchar(50),
		foreign key (Story_ID) references STORY (Title),
	PublicationYear YEAR,
	FirstEd BOOL
);

CREATE TABLE AUDIO_FORMAT (
    AUDIO_FORMAT_ID smallint unsigned not null auto_increment PRIMARY KEY,
	AUDIO_BOOK_ID smallint unsigned not null,
		FOREIGN KEY (AUDIO_BOOK_ID) REFERENCES AUDIO_BOOK(AUDIO_BOOK_ID),
	AudioFormat ENUM("Digital", "CD", "Cassette"),
    MediaQuantity TINYINT,
    AudioISBN VARCHAR(16)  
);

create table EDITION_DIMENSION (
	Edition_Dimension_ID smallint unsigned not null auto_increment PRIMARY KEY,
	Edition_ID smallint unsigned not null,
		foreign key(Edition_ID) references EDITION (Edition_ID),
	Dimensions_ID smallint unsigned not null,
		foreign key(Dimensions_ID) references DIMENSIONS (Dimensions_ID),
	BookISBN varchar (16)
);

CREATE TABLE NARRATION (
    NARRATION_ID smallint unsigned not null auto_increment PRIMARY KEY,
    NARRATOR_ID smallint unsigned not null, 
		FOREIGN KEY (NARRATOR_ID) REFERENCES NARRATOR(NARRATOR_ID),
	AUDIO_BOOK_ID smallint unsigned not null,
		FOREIGN KEY (AUDIO_BOOK_ID) REFERENCES AUDIO_BOOK(AUDIO_BOOK_ID),
	Role VARCHAR(25)
);

INSERT INTO art_style VALUES (1,1,0,0),(2,0,1,0),(3,1,0,1),(4,0,1,1);
INSERT INTO story VALUES ('A hat full of sky',2004,'A real witch can ride a broomstick, cast spells and make a proper shamble out of nothing. Eleven-year-old Tiffany Aching can\'t. A real witch never casually steps out of her body, leaving it empty. Tiffany does. And there\'s something just waiting for a handy body to take over. Something ancient and horrible, which can\'t die. Now she\'s got to fight back and learn to be a real witch really quickly, with the help of arch-witch Mistress Weatherwax and the truly amazing Miss Level... \'Crivens! And us!\' Oh, yes. And the Nac Mac Feegle â€“ the rowdiest, toughest, smelliest bunch of fairies ever to be thrown out of Fairyland for being drunk at two in the afternoon. They\'ll fight anything. And even they might not be enough...',32,'Tiffany Aching'),('Carpe jugulum',1998,'Mightily Oats has not picked a good time to be a priest. He thought he\'d come to the mountain kingdom of Lancre for a simple little religious ceremony. Now he\'s caught up in a war between vampires and witches, and he\'s not sure there is a right side. There\'re the witches - young Agnes, who is really in two minds about everything, Magrat, who is trying to combine witchcraft and nappies, Nanny Ogg, who is far too knowing... and Granny Weatherwax, who is big trouble. And the vampires are intelligent - not easily got rid of with a garlic enema or by going to the window, grasping the curtains and saying, \'I don\'t know about you, but isn\'t it a bit stuffy in here?\' They\'ve got style and fancy waistcoats. They\'re out of the casket and want a bite of the future. Mightily Oats knows he has a prayer, but wishes he had an axe.',23,'Witches'),('Equal rites',1987,'The last thing the wizard Drum Billet did, before Death laid a bony hand on his shoulder, was to pass on his staff of power to the eighth son of an eighth son. Unfortunately for his colleagues in the chauvinistic (not to say misogynistic) world of magic, he failed to check on the new-born baby\'s sex...',3,'Witches'),('Eric',1990,'Eric is the Discworld\'s only demonology hacker. Pity he\'s not very good at it. All he wants is three wishes granted. Nothing fancy - to be immortal, rule the world, have the most beautiful woman in the world fall madly in love with him, the usual stuff. But instead of a tractable demon, he calls up Rincewind, probably the most incompetent wizard in the universe, and the extremely intractable and hostile form of travel accessory known as the Luggage. With them on his side, Eric\'s in for a ride through space and time that is bound to make him wish (quite fervently) again - this time that he\'d never been born.',9,'Rincewind'),('Feet of clay',1996,'A Discworld Whodunnit. Who\'s murdering harmless old men? Who\'s poisoning the Patrician? As autumn fogs hold Ankh-Morpork in their grip, the City Watch have to track down a murderer who can\'t be seen. Maybe the golems know something - but the solemn men of clay, who work all day and night and are never any trouble to anyone, have started to commit suicide... It\'s not as if the Watch hasn\'t got problems of its own. There\'s a werewolf suffering from Pre-Lunar Tension. Corporal Nobbs is hobnobbing with the nobs, and there\'s something really strange about the new dwarf recruit, especially his earrings and eyeshadow. Who can you trust when there are mobs on the streets and plotters in the dark and all the clues point the wrong way? In the gloom of the night, Watch Commander Sir Samuel Vimes finds that the truth might not be out there at all. It may be in amongst the words in the head. A chilling tale of poison and pottery.',19,'City Watch'),('Going postal',2004,'Moist von Lipwig is a con artist and a fraud and a man faced with a life choice: be hanged, or put Ankh-Morpork\'s ailing postal service back on its feet. It\'s a tough decision. But he\'s got to see that the mail gets through, come rain, hail, sleet, dogs, the Post Office Workers Friendly and Benevolent Society, the evil chairman of the Grand Trunk Semaphore Company, and a midnight killer. And don\'t forget the legendary Mrs. Cake! Getting a date with Adora Belle Dearheart would be nice, too. Maybe it\'ll take a criminal to succeed where honest men have failed, or maybe it\'s a death sentence either way. Or perhaps there\'s a shot at redemption in the mad world of the mail, waiting for a man who\'s prepared to push the envelope...',33,'Industrial Revolution'),('Guards! Guards!',1989,'This is where the dragons went. They lie ... not dead, not asleep, but... dormant. And although the space they occupy isn\'t like normal space, nevertheless they are packed in tightly. They could put you in mind of a can of sardines, if you thought sardines were huge and scaly. And presumably, somewhere, there\'s a key... Guards! Guards! is the eighth Discworld novel â€“ and after this, dragons will never be the same again!',8,'City Watch'),('Hogfather',1996,'It\'s the night before Hogswatch. And it\'s too quiet. There\'s snow, there\'re robins, there\'re trees covered with decorations, but there\'s a notable lack of the big fat man who delivers the toys... Susan the governess has got to find him before morning, otherwise the sun won\'t rise. And unfortunately, her only helpers are a raven with an eyeball fixation, the Death of Rats and an oh god of hangovers. Worse still, someone is coming down the chimney. This time he\'s carrying a sack instead of a scythe, but there\'s something regrettably familiar... Ho. Ho. Ho. It\'s true what they say. \'You\'d better watch out...\'',20,'Death'),('I shall wear midnight',2010,'A man with no eyes. No eyes at all. Two tunnels in his head... It\'s not easy being a witch, and it\'s certainly not all whizzing about on broomsticks, but Tiffany Aching - teen witch - is doing her best. Until something evil wakes up, something that stirs up all the old stories about nasty old witches, so that just wearing a pointy hat suddenly seems a very bad idea. Worse still, this evil ghost from the past is hunting down one witch in particular. He\'s hunting for Tiffany. And he\'s found her... A fabulous Discworld title filled with witches and magic and told in the inimitable Terry Pratchett style, I Shall Wear Midnight is the fourth Discworld title to feature Tiffany and her tiny, fightin\', boozinâ€™ pictsie friends, the Nac Mac Feegle (aka The Wee Free Men).',38,'Tiffany Aching'),('Interesting times',1994,'Mighty Battles! Revolution! Death! War! (and his sons Terror and Panic, and daughter Clancy). The oldest and most inscrutable empire on the Discworld is in turmoil, brought about by the revolutionary treatise What I Did On My Holidays. Workers are uniting, with nothing to lose but their water buffaloes. Warlords are struggling for power. War (and Clancy) are spreading through the ancient cities. And all that stands in the way of terrible doom for everyone is: Rincewind the Wizzard, who can\'t even spell the word \'wizard\'... Cohen the barbarian hero, five foot tall in his surgical sandals, who has had a lifetime\'s experience of not dying...and a very special butterfly.',17,'Rincewind'),('Jingo',1997,'Discworld goes to war... A weathercock has risen from the sea of Discworld. Suddenly you can tell which way the wind is blowing. A new land has surfaced, and so have old feuds. And as two armies march, Commander Vimes of the Ankh-Morpork City Watch has got just a few hours to deal with a crime so big that there\'s no law against it. It\'s called \'war.\' He\'s facing unpleasant foes who are out to get him... and that\'s just the people on *his* side. The enemy might be worse. And his pocket Dis-organiser says he\'s got \'Die\' under \'Things To Do Today\'. But he\'d better not, because the world\'s cleverest inventor and its most devious politician are on their way to the battlefield with a little package that\'s guaranteed to stop a battle... Discworld goes to war, with armies of sardines, warriors, fishermen, squid, and at least one very camp follower.',21,'City Watch'),('Lords and ladies',1992,'It\'s a hot Midsummer Night. The crop circles are turning up everywhere â€“ even on the mustard-and-cress of Pewsey Ogg, aged four. And Magrat Garlick, witch, is going to be married in the morning... Everything ought to be going like a dream. But the Lancre All-Comers Morris Team have got drunk on a fairy mound and the elves have come back, bringing all those things traditionally associated with the magical, glittering realm of Faerie: cruelty, kidnapping, malice and evil, evil murder.[*] Granny Weatherwax and her tiny argumentative coven have really got their work cut out this time... With full supporting cast of dwarfs, wizards, trolls, Morris Dancers and one orang-utan. And lots of hey-nonny-nonny and blood all over the place. [*] But with tons of style.',14,'Witches'),('Making money',2007,'It\'s an offer you can\'t refuse. Who would not to wish to be the man in charge of Ankh-Morpork\'s Royal Mint and the bank next door? It\'s a job for life. But, as former con-man Moist von Lipwig is learning, the life is not necessarily for long. The Chief Cashier is almost certainly a vampire. There\'s something nameless in the cellar (and the cellar itself is pretty nameless), it turns out that the Royal Mint runs at a loss. A 300 year old wizard is after his girlfriend, he\'s about to be exposed as a fraud, but the Assassins\' Guild might get him first. In fact lot of people want him dead. Oh... and every day he has to take the Chairman for walkies. Everywhere he looks he\'s making enemies. What he should be doing is... Making Money!',36,'Industrial Revolution'),('Maskerade',1995,'The Opera House, Ankh-Morpork... a huge, rambling building, where masked figures and hooded shadows do wicked deeds in the wings... where dying the death on stage is a little bit more than just a metaphor... where innocent young sopranos are lured to their destiny by an evil mastermind in a hideously deformed evening dress... Where... there\'s a couple of old ladies in pointy hats eating peanuts in the stalls and looking at the big chandelier and saying things like: \'There\'s an accident waiting to happen if ever I saw one\'. Yes... Granny Weatherwax and Nanny Ogg, the Discworld\'s greatest witches, are back for an innocent night at the opera. So there\'s going to be trouble (but nevertheless a good evening\'s entertainment with murders you can really hum).',18,'Witches'),('Men at arms',1993,'Be a MAN in the City Watch! The City watch needs MEN!\' But what it\'s got includes Corporal Carrot (technically a dwarf), Lance-constable Cuddy (really a dwarf), Lance-constable Detritus (a troll), Lance-constable Angua (a woman... most of the time) and Corporal Nobbs (disqualified from the human race for shoving). And they need all the help they can get. Because there\'s evil in the air and murder afoot and something very nasty in the streets. It\'d help if it could all be sorted out by noon, because that\'s when Captain Vimes is officially retiring, handing in his badge and getting married. And since this is Ankh-Morpork, noon promises to be not just high, but stinking.',15,'City Watch'),('Monstrous regiment',2003,'It was a sudden strange fancy... Polly Perks had to become a boy in a hurry. Cutting off her hair and wearing trousers was easy. Learning to fart and belch in public and walk like an ape took more time... And now she\'s enlisted in the army, and searching for her lost brother. But there\'s a war on. There\'s always a war on. And Polly and her fellow recruits are suddenly in the thick of it, without any training, and the enemy is hunting them. All they have on their side is the most artful sergeant in the army and a vampire with a lust for coffee. Well... they have the Secret. And as they take the war to the heart of the enemy, they have to use all the resources of... the Monstrous Regiment.',31,'Standalone'),('Mort',1987,'Death comes to us all. When he came to Mort, he offered him a job. After being assured that being dead was not compulsory, Mort accepted. However, he soon found that romantic longings did not mix easily with the responsibilities of being Death\'s apprentice...',4,'Death'),('Moving pictures',1990,'The alchemists of the Discworld have discovered the magic of the silver screen. But what is the dark secret of Holy Wood hill? It\'s up to Victor Tugelbend (\'Can\'t sing. Can\'t dance. Can handle a sword a little\') and Theda Withel (\'I come from a little town you\'ve probably never heard of\') to find out... Moving Pictures, the tenth Discworld novel, is a gloriously funny saga set against the background of a world gone mad!',10,'Standalone'),('Night watch',2002,'This morning, Commander Vimes of the City Watch had it all. He was a Duke. He was rich. He was respected. He had a titanium cigar case. He was about to become a father. This morning he thought longingly about the good old days. Tonight, he\'s in them. Flung back in time by a mysterious accident, Sam Vimes has to start all over again. He must get a new name and a job, and there\'s only one job he\'s good at: cop in the Watch. He must track down a brutal murderer. He must find his younger self and teach him everything he knows. He must whip the cowardly, despised Night Watch into a crack fighting force â€“ fast. Because Sam Vimes knows what\'s going to happen. He remembers it. He was there. It\'s part of history. And you can\'t change history... But Sam is going to. He has no choice. Otherwise, a bloody revolution will start, and good men will die. Sam saw their names on old headstones just this morning â€“ but tonight they\'re young men who think they have a future. And rather than let them die, Sam will do anything â€“ turn traitor, burn buildings, take over a revolt, anything â€“ to snatch them from the jaws of history. He will do it even if victory will mean giving up the only future he knows. For if he succeeds, he\'s got no wife, no child, no riches, no fame â€“ all that will simply vanish. But if he doesn\'t try, he wouldn\'t be Sam Vimes. And so the battle is on. He knows how it\'s going to end; after all, he was there. His name is on one of those headstones. But that\'s just a minor detail...',29,'City Watch'),('Pyramids',1989,'Being trained by the Assassins\' Guild in Ankh-Morpork did not fit Teppic for the task assigned to him by fate. He inherited the throne of the desert kingdom of Djelibeybi rather earlier than he expected (his father wasn\'t too happy about it either), but that was only the beginning of his problems...',7,'Standalone'),('Raising steam',2013,'Raising Steam Takes place 8 years after The Fifth Elephant. To the consternation of the patrician, Lord Vetinari, a new invention has arrived in Ankh-Morpork - a great clanging monster of a machine that harnesses the power of all of the elements: earth, air, fire and water. This being Ankh-Morpork, it\'s soon drawing astonished crowds, some of whom caught the zeitgeist early and arrive armed with notepads and very sensible rainwear. Moist von Lipwig is not a man who enjoys hard work - as master of the Post Office, the Mint and the Royal Bank his input is, of course, vital... but largely dependent on words, which are fortunately not very heavy and don\'t always need greasing. However, he does enjoy being alive, which makes a new job offer from Vetinari hard to refuse... Steam is rising over Discworld, driven by Mister Simnel, the man wi\' t\'flat cap and sliding rule who has an interesting arrangement with the sine and cosine. Moist will have to grapple with gallons of grease, goblins, a fat controller with a history of throwing employees down the stairs and some very angry dwarfs if he\'s going to stop it all going off the rails...',40,'Industrial Revolution'),('Reaper man',1991,'Death is missing, presumed... er... gone. Which leads to the kind of chaos to always expect when an important public service is withdrawn. Ghosts and poltergeists fill up the Discworld. Dead Rights activist Reg Shoe - \'You Don\'t Have to Take This Lying Down\' - suddenly has more work than he had ever dreamed of. And newly deceased wizard Windle Poons wakes up in his coffin to find that he has come back as a corpse. But it\'s up to Windle and the members of Ankh-Morpork\'s rather unfrightening group of undead* to save the world for the living. Meanwhile, on a little farm far, far away, a tall, dark stranger, by the name of Bill Door, is turning out to be really good with a scythe. There\'s a harvest to be got in. And a different battle to be fought. In passing we learn of many things. The lifecycles of Mayflies and Counting pines; of the Klatchian Foreign Legion, where men go to forget; of the true colour of infinity; and of chocolate, flowers, and gemstones as items which ease the path to a lady\'s heart. *Arthur Winkings, for example, became a vampire after being bitten by a lawyer. Schleppel the bogeyman would be better at his job if he wasn\'t agoraphobic and frightened of coming out of the closet. And Mr Ixolite is a banshee with a speech impediment, so instead of standing on the roof and screaming when there\'s a death in the house he writes \'OooEeeOooEeeOoo\' on a piece of paper and pushes it under the door.',11,'Death'),('Small gods',1992,'Brutha is the Chosen One. His god has spoken to him, admittedly while currently in the shape of a tortoise. Brutha is a simple lad. He can\'t read. He can\'t write. He\'s pretty good at growing melons. And his wants are few. He wants to overthrow a huge and corrupt church. He wants to prevent a horrible holy war. He wants to stop the persecution of a philosopher who has dared to suggest that, contrary to the Church\'s dogma, the Discworld really does go through space on the back of an enormous turtle (*). He wants peace and justice and brotherly love. He wants the Inquisition to stop torturing him now, please. But most of all, what he really wants, more than anything else, is for his god to Choose Someone Else... (* which is true, but when has that ever mattered?)',13,'Standalone'),('Snuff',2011,'According to the writer of the best selling crime novel ever to have been published in the city of Ankh-Morpork, it is a truth universally acknowledged that a policeman taking a holiday would barely have had time to open his suitcase before he finds his first corpse. And Commander Sam Vimes of the Ankh-Morpork City Watch is on holiday in the pleasant and innocent countryside, but not for him a mere body in the wardrobe, but many, many bodies and an ancient crime more terrible than murder. He is out of his jurisdiction, out of his depth, out of bacon sandwiches, occasionally snookered and occasionally out of his mind, but not out of guile. Where there is a crime there must be a finding, there must be a chase and there must be a punishment. They say that in the end all sins are forgiven. But not quite all...',39,'City Watch'),('Soul music',1994,'Other children got given xylophones. Susan just had to ask her grandfather to take his vest off. Yes. There\'s a Death in the family. It\'s hard to grow up normally when Grandfather rides a white horse and wields a scythe â€“ especially when you have to take over the family business, and everyone mistakes you for the Tooth Fairy. And especially when you have to face the new and addictive music that has entered the Discworld. It\'s Lawless. It changes people. It\'s called Music With Rocks In. It\'s got a beat and you can dance to it, but... It\'s alive. And it won\'t fade away.',16,'Death'),('Sourcery',1988,'There was an eighth son of an eighth son. He was, quite naturally, a wizard. And there it should have ended. However (for reasons we\'d better not go into), he had seven sons. And then he had an eighth son... a wizard squared... a source of magic... a Sourcerer.',5,'Rincewind'),('The amazing Maurice and his educated rodents',2001,'Imagine a million clever rats. Rats that don\'t run. Rats that fight... Maurice, a streetwise tomcat, has the perfect money-making scam. He\'s found a stupid-looking kid who plays a pipe, and he has his very own plague of rats who are strangely educated, so Maurice can no longer think of them as \'lunch\'. And everyone knows the stories about rats and pipers... But when they reach the stricken town of Bad Blintz, the little con suddenly goes down the drain. For someone there is playing a different tune. A dark, shadowy tune. Something very, very bad is waiting in the cellars. The educated rats must learn a new word. EVIL. It\'s not a game any more. It\'s a rat-eat-rat world down there. And that might only be the start... Terry Pratchett leads readers from tale to tail in a darkly imaginative and fiendishly entertaining story, the first for young readers set in the Discworld universe.',28,'Standalone'),('The colour of magic',1983,'On a world supported on the back of a giant turtle (sex unknown), a gleeful, explosive, wickedly eccentric expedition sets out. There\'s an avaricious but inept wizard, a naive tourist whose luggage moves on hundreds of dear little legs, dragons who only exist if you believe in them, and of course THE EDGE of the planet...',1,'Rincewind'),('The fifth elephant',1999,'A Discworld novel of dwarfs, diplomacy, intrigue and big lumps of fat. Sam Vimes is a man on the run. Yesterday he was a duke, a chief of police and the ambassador to the mysterious, fat-rich country of Uberwald. Now he has nothing but his native wit and the gloomy trousers of Uncle Vanya (don\'t ask). It\'s snowing. It\'s freezing. And if he can\'t make it through the forest to civilization there\'s going to be a terrible war. But there are monsters on his trail. They\'re bright. They\'re fast. They\'re werewolves - and they\'re catching up. Sam Vimes is out of time, out of luck and already out of breath... The story also contains a locked room mystery. Almost every fictional detective used to get lumbered with one of these in his or her career, some, like Ellery Queen seemed to trip over them almost weekly. This time it\'s Vimes\' turn. The situation isn\'t helped by the fact that this is, as Sam works out almost at once, \'A locked room where they left the bloody door open!\'',24,'City Watch'),('The last continent',1998,'This is the Discworld\'s last continent, a completely separate creation. It\'s hot. It\'s dry... very dry. There was this thing once called The Wet, which no one now believes in. Practically everything that\'s not poisonous is venomous. But it\'s the best bloody place in the world, all right? And it\'ll die in a few days. Except... Who is this hero striding across the red desert? Champion sheep shearer, horse rider, road warrior, beer drinker, bush ranger and someone who\'ll even eat a Meat Pie Floater when he\'s sober? A man in a hat, whose Luggage follows him on little legs, who\'s about to change history by preventing a swagman stealing a jumbuck by a billabong? Yes... all this place has between itself and wind-blown doom is Rincewind, the inept wizard who can\'t even spell wizard. He\'s the only hero left. Still... no worries, eh?',22,'Rincewind'),('The last hero',2001,'He\'s been a legend in his own lifetime. He can remember the great days of high adventure. He can remember when a hero didn\'t have to worry about fences and lawyers and civilisation. He can remember when people didn\'t tell you off for killing dragons. But he can\'t always remember, these days, where he put his teeth... He\'s really not happy about that bit. So now, with his ancient sword and his new walking stick and his old friends â€“ and they\'re very old friends â€“ Cohen the Barbarian is going on one final quest. It\'s been a good life. He\'s going to climb the highest mountain in the Discworld and meet his gods. He doesn\'t like the way they let men grow old and die. It\'s time, in fact, to give something back. The last hero in the world is going to return what the first hero stole. With a vengeance. That\'ll mean the end of the world, if no one stops him in time. Someone is going to try. So who knows who the last hero really is?',27,'Rincewind'),('The light fantastic',1986,'As it moves towards a seemingly inevitable collision with a malevolent red star, the Discworld has only one possible saviour. Unfortunately, this happens to be the singularly inept and cowardly wizard called Rincewind, who was last seen falling off the edge of the world....',2,'Rincewind'),('The shepherd\'s crown',2015,'Deep in the Chalk, something is stirring. The owls and the foxes can sense it, and Tiffany Aching feels it in her boots. An old enemy is gathering strength. This is a time of endings and beginnings, old friends and new, a blurring of edges and a shifting of power. Now Tiffany stands between the light and the dark, the good and the bad. As the fairy horde prepares for invasion, Tiffany must summon all the witches to stand with her. To protect the land. Her land. There will be a reckoning...',41,'Tiffany Aching'),('The truth',2000,'William de Worde is the accidental editor of the Discworld\'s first newspaper. Now he must cope with the traditional perils of a journalist\'s life -- people who want him dead, a recovering vampire with a suicidal fascination for flash photography, some more people who want him dead in a different way and, worst of all, the man who keeps begging him to publish pictures of his humorously shaped potatoes. William just wants to get at THE TRUTH. Unfortunately, everyone else wants to get at William. And it\'s only the third edition...',25,'Standalone'),('The wee free men',2003,'There\'s trouble on the Aching farm â€“ a monster in the river, a headless horseman in the driveway and nightmares spreading down from the hills. And now Tiffany Aching\'s little brother has been stolen by the Queen of the Fairies (although Tiffany doesn\'t think this is entirely a bad thing). Tiffany\'s got to get him back. To help her, she has a weapon (a frying pan), her granny\'s magic book (well, Diseases of the Sheep, actually) andâ€” \'Crivens! Whut aboot us, ye daftie!\' â€”oh yes. She\'s also got the Nac Mac Feegle, the Wee Free Men, the fightin\', thievin\', tiny blue-skinned pictsies who were thrown out of Fairyland for being Drunk and Disorderly... A wise, witty and wonderfully inventive adventure set on the Discworld.',30,'Tiffany Aching'),('Thief of time',2001,'Time is a resource. Everyone knows it has to be managed. And on Discworld that is the job of the Monks of History, who store it and pump it from the places where it\'s wasted (like underwater -- how much time does a codfish need?) to places like cities, where there\'s never enough time. But the construction of the world\'s first truly accurate clock starts a race against, well, time, for Lu Tze and his apprentice Lobsang Ludd. Because it will stop time. And that will only be the start of everyone\'s problems. Thief of Time comes complete with a full supporting cast of heroes and villains, yetis, martial artists and Ronnie, the fifth Horseman of the Apocalypse (who left before they became famous).',26,'Death'),('Thud!',2005,'THUD! Koom Valley? That was where the trolls ambushed the dwarfs, or the dwarfs ambushed the trolls. It was far away. It was a long time ago. But if he doesn\'t solve the murder of just one dwarf, Commander Sam Vimes of Ankh-Morpork City Watch is going to see the battle fought again, right outside his office (and perhaps inside his own Watch House). With his beloved Watch crumbling around him and war-drums sounding, he must unravel every clue, outwit every assassin and brave any darkness to find the solution. And darkness is following him.',34,'City Watch'),('Unseen academicals',2009,'Football has come to the ancient city of Ankh-Morpork â€“ not the old fashioned, grubby pushing and shoving, but the new, fast football with pointy hats for goalposts and balls that go gloing when you drop them. And now, the wizards of Unseen University must win a football match, without using magic, so they\'re in the mood for trying everything else. The prospect of the Big Match draws in a likely lad with a wonderful talent for kicking a tin can, a maker of jolly good pies, a dim but beautiful young woman who might just turn out to be the greatest fashion model there has ever been, and the mysterious Mr Nutt. (No one knows anything much about Mr Nutt, not even Mr Nutt, which worries him, too.) As the match approaches, four lives are entangled and changed for ever. Because the thing about football â€“ the important thing about football â€“ is that it is not just about football. Here we go! Here we go! Here we go!',37,'Standalone'),('Wintersmith',2006,'At 9, Tiffany Aching defeated the cruel Queen of Fairyland. At 11, she battled an ancient body-stealing evil. At 13, Tiffany faces a new challenge: a boy. And boys can be a bit of a problem when you\'re thirteen... But the Wintersmith isn\'t \'exactly\' a boy. He is Winter itself - snow, gales, icicles - all of it. When he has a crush on Tiffany, he may make her roses out of ice, but his nature is blizzards and avalanches. And he wants Tiffany to stay in his gleaming, frozen world. Forever. Tiffany will need all her cunning to make it to Spring. She\'ll also need her friends, from junior witches to the legendary Granny Weatherwax. \'Crivens!\' Tiffany will need the Wee Free Men too! She\'ll have the help of the bravest, toughest, smelliest pictsies ever to be banished from Fairyland - whether she wants it or not. It\'s going to be a cold, cold season, because if Tiffany doesn\'t survive until Spring - Spring won\'t come.',35,'Tiffany Aching'),('Witches abroad',1991,'It seemed an easy job... After all, how difficult could it be to make sure that a servant girl doesn\'t marry a prince? But for the witches Granny Weatherwax, Nanny Ogg and Magrat Garlick, traveling to the distant city of Genua, things are never that simple... For one thing, all they\'ve got is Mrs. Gogol\'s voodoo, a one-eyed cat and a second-hand magic wand that can only do pumpkins. And they\'re up against the malignant power of the Godmother herself, who has made Destiny an offer it can\'t refuse. And finally there\'s the sheer power of the Story. Servant girls have to marry the Prince. That\'s what life is all about. You can\'t fight a Happy Ending. At least â€“ up until now...',12,'Witches'),('Wyrd sisters',1988,'Witches are not by their nature gregarious, and they certainly don\'t have leaders. Granny Weatherwax was the most highly-regarded of the leaders they didn\'t have. But even she found that meddling in royal politics was a lot more difficult than certain playwrights would have you believe...',6,'Witches');
INSERT INTO cover_artist VALUES (1,'Leo','Nickolls'),(2,'Paul','Kidby'),(3,'Josh','Kirby'),(4,'Laura Ellen','Anderson'),(5,'Joe','McLaren'),(6,'Unknown','Unknown'),(7,'Michael','Sabanosh'),(8,'Chip','Kidd'),(9,'Istvan','Orosz'),(10,'Scott','McKowen'),(11,'Jim','Tierney'),(12,'David','Wyatt');
INSERT INTO publisher VALUES (2,'HarperCollins'),(3,'ISIS Audio Books'),(4,'Orion'),(5,'Transworld'),(6,'Knopf-Doubleday');
INSERT INTO size VALUES (1,NULL,NULL,293),(2,19.8,1.7,288),(3,NULL,NULL,224),(4,19,1.3,276),(5,17.8,2,251),(6,20.5,2.8,295),(7,24,1.8,283),(8,25,1.8,295),(9,23,2,324),(10,NULL,NULL,362),(11,24,2,338),(12,18,1.9,409),(13,NULL,NULL,533),(14,25,2.3,399),(15,20,3.2,400),(16,20,1.6,326),(17,17.8,2.3,380),(18,19.05,2.11,368),(19,24,1.8,289),(20,19,2.3,368),(21,19.8,2.5,416),(22,20.4,3.71,336),(23,20.32,2.01,352),(24,20.4,4,464),(25,24.13,2.67,400),(26,19.9,2.7,257),(27,20,1.7,126),(28,11,2.6,384),(29,12.7,2.6,448),(30,17.8,1.6,272),(31,17.78,1.91,352),(32,19.8,2.8,480),(33,12.7,1.91,400),(34,17.78,1.91,352),(35,20.5,2.8,296),(36,24.13,1.91,176),(37,20,1.6,329),(38,20.2,1.7,325),(39,12,2.7,378),(40,24,2,336);
INSERT INTO publisher_location VALUES (1,'UK','Oxford'),(2,'UK','London'),(3,'United States','New York');
INSERT INTO narrator VALUES (1,'Andy','Serkis'),(2,'Bill','Nighy'),(3,'Colin','Morgan'),(4,'Indira','Varma'),(5,'Jon','Culshaw'),(6,'Nigel','Planer'),(7,'Peter','Serafinowicz'),(8,'Richard','Coyle'),(9,'Stephen','Briggs'),(10,'Steven','Cree'),(11,'Tony','Robinson');
INSERT INTO publisher_imprint VALUES (1,2,'Clarion'),(2,5,'Corgi'),(3,5,'Corgi Audio'),(4,5,'Corgi Childrens'),(5,6,'Doubleday'),(6,4,'Gollancz'),(7,2,'Harper'),(8,2,'HarperAudio'),(9,2,'HarperCollins'),(10,2,'HarperCollins e-books'),(11,2,'HarperPrism'),(12,2,'HarperTempest'),(13,2,'HarperTorch'),(14,3,'ISIS Audio Books'),(15,5,'Penguin Audio'),(16,5,'Transworld'),(17,5,'Transworld Digital');
INSERT INTO cover_art VALUES (1,5,'Witches abroad',1,NULL),(2,3,'Interesting times',2,NULL),(3,7,'Interesting times',1,NULL),(4,3,'The colour of magic',1,NULL),(5,3,'The colour of magic',1,NULL),(6,6,'Jingo',2,NULL),(7,8,'The truth',2,NULL),(8,2,'Night watch',1,NULL),(9,9,'Night watch',2,NULL),(10,6,'Going postal',2,NULL),(11,10,'Unseen academicals',1,NULL),(12,2,'Unseen academicals',1,NULL),(13,4,'The shepherd\'s crown',3,NULL),(14,6,'The shepherd\'s crown',2,NULL),(15,3,'Sourcery',1,NULL),(16,6,'Sourcery',2,NULL),(17,2,'Guards! Guards!',3,NULL),(18,3,'A hat full of sky',1,NULL),(19,6,'Carpe jugulum',2,NULL),(20,3,'Equal rites',1,NULL),(21,3,'Eric',3,NULL),(22,6,'Feet of clay',2,NULL),(23,1,'Hogfather',1,NULL),(24,6,'I shall wear midnight',3,NULL),(25,6,'I shall wear midnight',3,NULL),(26,1,'The last continent',3,NULL),(27,3,'The last continent',3,NULL),(28,1,'The light fantastic',1,NULL),(29,1,'The light fantastic',1,NULL),(30,6,'Lords and ladies',2,NULL),(31,1,'Making money',1,NULL),(32,6,'Maskerade',1,NULL),(33,6,'Men at arms',1,NULL),(34,2,'Monstrous regiment',1,NULL),(35,5,'Mort',1,NULL),(36,5,'Moving pictures',1,NULL),(37,4,'Moving pictures',1,NULL),(38,6,'Pyramids',1,NULL),(39,1,'Raising steam',1,NULL),(40,6,'Reaper man',2,NULL),(41,1,'Small gods',1,NULL),(42,2,'Snuff',1,NULL),(43,3,'Soul music',1,NULL),(44,2,'The last hero',3,NULL),(45,12,'The amazing Maurice and his educated rodents',2,NULL),(46,1,'The fifth elephant',1,NULL),(47,6,'Thief of time',1,NULL),(48,6,'Thief of time',1,NULL),(49,6,'Thud!',1,NULL),(50,6,'Thud!',1,NULL),(51,12,'The wee free men',1,NULL),(52,3,'The wee free men',1,NULL),(53,6,'Wintersmith',1,NULL),(54,6,'Wyrd sisters',1,NULL),(55,2,'Wyrd sisters',1,NULL),(56,2,'Men at arms',1,NULL),(57,2,'Maskerade',1,NULL);
INSERT INTO dimensions VALUES (1,1,'Ebook'),(2,4,'Paperback'),(3,3,'Hardcover'),(4,27,'Hardcover'),(5,40,'Hardcover'),(6,7,'Hardcover'),(7,8,'Hardcover'),(8,9,'Hardcover'),(9,10,'Hardcover'),(10,11,'Ebook'),(11,12,'Hardcover'),(12,13,'Paperback'),(13,14,'Ebook'),(14,15,'Hardcover'),(15,17,'Paperback'),(16,19,'Paperback'),(17,20,'Paperback'),(18,28,'Hardcover'),(19,29,'Paperback'),(20,30,'Paperback'),(21,31,'Paperback'),(22,32,'Paperback'),(23,33,'Paperback'),(24,34,'Paperback'),(25,35,'Paperback'),(26,36,'Hardcover'),(27,37,'Paperback'),(28,38,'Paperback'),(29,39,'Hardcover'),(30,40,'Hardcover'),(31,2,'Paperback'),(32,6,'Paperback'),(33,16,'Hardcover'),(34,18,'Paperback'),(35,21,'Paperback'),(36,22,'Paperback'),(37,23,'Hardcover'),(38,24,'Paperback'),(39,25,'Hardcover'),(40,26,'Hardcover');
INSERT INTO publication VALUES (1,17,2),(2,14,1),(3,14,1),(4,7,3),(5,6,2),(6,6,2),(7,6,2),(8,11,3),(9,3,2),(10,7,3),(11,17,2),(12,9,3),(13,13,3),(14,10,3),(15,5,2),(16,4,2),(17,3,3),(18,6,2),(19,7,3),(20,2,2),(21,2,2),(22,2,2),(23,7,3),(24,7,3),(25,5,2),(26,12,3),(27,5,2),(28,6,2),(29,6,2),(30,15,2),(31,2,2),(32,2,2),(33,15,2),(34,2,2),(35,2,2),(36,2,2),(37,15,2),(38,16,2),(39,15,2),(40,2,2),(41,15,2),(42,16,2),(43,14,1),(44,2,2),(45,15,2),(46,7,3),(47,16,2),(48,16,2),(49,14,1),(50,16,2),(51,17,2),(52,1,2),(53,15,2),(54,9,3),(55,9,3),(56,15,2),(57,5,3);
INSERT INTO audio_book VALUES (1,'The colour of magic',5,2,1995,'07:00:00',0),(2,'The light fantastic',29,39,2022,'07:42:00',0),(3,'Sourcery',15,3,2003,'07:55:17',0),(4,'Jingo',6,9,2006,'03:19:33',1),(5,'The shepherd\'s crown',14,17,2015,'07:49:16',0),(6,'Wyrd sisters',55,41,2022,'09:53:00',0),(7,'Moving pictures',37,43,2008,'10:10:00',0),(8,'Men at arms',56,45,2023,'13:05:55',0),(9,'Maskerade',57,47,2022,'10:11:56',0),(10,'Small gods',41,30,2022,'11:58:00',0),(11,'The fifth elephant',46,33,2023,'13:51:00',0),(12,'Raising steam',39,37,2023,'13:57:00',0),(13,'The last continent',27,49,2008,'09:56:00',0),(14,'Thief of time',48,51,2007,'10:59:22',0),(15,'The wee free men',52,53,2023,'08:52:38',0),(16,'Thud!',50,55,2023,'12:38:03',0),(17,'I shall wear midnight',25,56,2023,'11:46:00',0);
INSERT INTO edition VALUES (1,4,1,'The colour of magic',2008,0),(2,16,4,'Sourcery',2008,0),(3,20,18,'Equal rites',1988,1),(4,35,28,'Mort',2013,0),(5,17,5,'Guards! Guards!',2020,0),(6,1,6,'Witches abroad',2014,0),(7,2,7,'Interesting times',1994,1),(8,3,8,'Interesting times',1996,0),(9,7,10,'The truth',2000,0),(10,8,11,'Night watch',2009,0),(11,9,12,'Night watch',2002,0),(12,10,13,'Going postal',2005,0),(13,11,14,'Unseen academicals',2009,0),(14,12,15,'Unseen academicals',2009,1),(15,13,16,'The shepherd\'s crown',2017,0),(16,38,19,'Pyramids',2008,0),(17,40,20,'Reaper man',2005,0),(18,21,29,'Eric',1990,1),(19,43,31,'Soul music',2013,0),(20,23,32,'Hogfather',2021,0),(21,45,34,'The amazing Maurice and his educated rodents',2003,1),(22,18,35,'A hat full of sky',2005,0),(23,31,36,'Making money',2023,0),(24,30,21,'Lords and ladies',2005,0),(25,22,22,'Feet of clay',2005,0),(26,19,23,'Carpe jugulum',1999,0),(27,44,24,'The last hero',2002,0),(28,34,25,'Monstrous regiment',2003,1),(29,53,26,'Wintersmith',2006,0),(30,42,27,'Snuff',2011,1),(31,28,38,'The light fantastic',2022,0),(32,54,40,'Wyrd sisters',1989,0),(33,36,42,'Moving pictures',2014,0),(34,33,44,'Men at arms',1994,0),(35,32,46,'Maskerade',2014,0),(37,47,50,'Thief of time',2017,0),(38,51,52,'The wee free men',2023,0),(39,49,54,'Thud!',2018,0),(40,24,57,'I shall wear midnight',2010,1),(41,26,48,'The last continent',2022,0);
INSERT INTO audio_format VALUES (1,1,'Cassette',6,'9781856958004'),(2,2,'Digital',NULL,'9780552140188'),(3,3,'CD',7,'9780753118337'),(4,4,'CD',3,'9780552154178'),(5,5,'Digital',NULL,'9781504645607'),(6,6,'Digital',NULL,'9781407032870'),(7,7,'CD',1,'9780753140338'),(8,8,'Digital',NULL,'9781473588653'),(9,9,'Digital',NULL,'9781473588547'),(10,13,'CD',1,'9780753140451'),(11,14,'CD',1,'9781407031576'),(12,15,'Digital',NULL,'9781473588493'),(13,16,'Digital',NULL,'9780063372177'),(14,17,'Digital',NULL,'9781446431436'),(15,10,'Digital',NULL,'9781804990193'),(16,11,'Digital',NULL,'9781473588523'),(17,12,'Digital',NULL,'9781473588301');
INSERT INTO edition_dimension VALUES (1,1,1,'9781407034379'),(2,31,31,'9781804990254'),(3,3,3,'9780575039506'),(4,4,4,'9781473200104'),(5,2,2,'9780062225726'),(6,32,32,'9780552134606'),(7,5,5,'9781473230712'),(8,6,6,'9781473200265'),(9,7,7,'9780575058002'),(10,8,8,'9780061052521'),(11,9,9,'9780380978953'),(12,10,10,'9781407035321'),(13,11,11,'9780060013110'),(14,12,12,'9780060502935'),(15,13,13,'9780061942037'),(16,14,14,'9780385609340'),(17,33,33,'9781473200234'),(18,15,15,'9780552576345'),(19,34,34,'9780552140287'),(20,16,16,'9780061020650'),(21,17,17,'9780552152952'),(22,35,35,'9780062275523'),(24,37,37,'9780857525031'),(25,38,38,'9780062435262'),(26,39,39,'9780857525918'),(27,40,40,'9780385611077'),(28,18,18,'9780575046368'),(29,19,19,'9780552140294'),(30,20,20,'9780552177306'),(31,21,21,'9780552546935'),(32,22,22,'9780552552646'),(33,23,23,'9781804990476'),(34,24,24,'9780552153157'),(35,25,25,'9780552153256'),(36,26,26,'9780061051586'),(37,27,27,'9780060507770'),(38,28,28,'9780552149419'),(39,29,29,'9780060890315'),(40,30,30,'9780385619264'),(42,41,36,'9781804990230');
INSERT INTO narration VALUES (1,6,1,'All'),(2,2,8,'Footnotes'),(3,7,6,'Death'),(4,3,2,'Book'),(5,6,3,'All'),(6,11,4,'All'),(7,6,7,'All'),(8,9,5,'All'),(9,5,8,'Book'),(10,4,9,'Book'),(11,6,13,'All'),(12,9,14,'All'),(13,10,15,'Nac Mac Feegles'),(14,4,15,'Book'),(15,2,15,'Footnotes'),(16,5,16,'Book'),(17,7,16,'Death'),(18,2,16,'Footnotes'),(19,10,17,'Nac Mac Feegles'),(20,4,17,'Book'),(21,2,17,'Footnotes'),(22,7,17,'Death'),(23,7,10,'Death'),(24,7,11,'Death'),(25,7,12,'Death'),(26,2,10,'Footnotes'),(27,2,11,'Footnotes'),(28,2,12,'Footnotes'),(29,1,10,'Book'),(30,5,11,'Book'),(31,8,12,'Book');

select * from cover_art;

SELECT * FROM DIMENSIONS WHERE BookFormat = 'Paperback';


SELECT STORY.Title, STORY.Copyright, PUBLISHER.PublisherName, EDITION.FirstEd, DIMENSIONS.BookFormat
FROM STORY 
LEFT JOIN EDITION ON STORY.Title = EDITION.Story_ID 
LEFT JOIN PUBLISHER_IMPRINT ON EDITION.Publication_ID = PUBLISHER_IMPRINT.PUBLISHER_IMPRINT_ID 
LEFT JOIN PUBLISHER ON PUBLISHER_IMPRINT.PUBLISHER_ID = PUBLISHER.PUBLISHER_ID 
LEFT JOIN EDITION_DIMENSION ON EDITION.Edition_ID = EDITION_DIMENSION.Edition_ID 
LEFT JOIN DIMENSIONS ON EDITION_DIMENSION.Dimensions_ID = DIMENSIONS.Dimensions_ID 
WHERE DIMENSIONS.BookFormat = 'paperback';

SELECT STORY.Title, STORY.Copyright, EDITION.FirstEd, PUBLISHER.PublisherName, DIMENSIONS.BookFormat
FROM STORY
LEFT JOIN EDITION ON STORY.Title = EDITION.Story_ID
LEFT JOIN PUBLISHER_IMPRINT ON EDITION.Publication_ID = PUBLISHER_IMPRINT.PUBLISHER_IMPRINT_ID
LEFT JOIN PUBLISHER ON PUBLISHER_IMPRINT.PUBLISHER_ID = PUBLISHER.PUBLISHER_ID
LEFT JOIN EDITION_DIMENSION ON EDITION.Edition_ID = EDITION_DIMENSION.Edition_ID
LEFT JOIN DIMENSIONS ON EDITION_DIMENSION.Dimensions_ID = DIMENSIONS.Dimensions_ID;


-- Counting the amount of books published under a publisher, and their imprint
SELECT PUBLISHER.PublisherName, PUBLISHER_IMPRINT.ImprintName, COUNT(STORY.Title) AS TotalBooksPublished
FROM PUBLISHER
LEFT JOIN PUBLISHER_IMPRINT ON PUBLISHER.PUBLISHER_ID = PUBLISHER_IMPRINT.PUBLISHER_ID
LEFT JOIN EDITION ON PUBLISHER_IMPRINT.PUBLISHER_IMPRINT_ID = EDITION.Publication_ID
LEFT JOIN STORY ON EDITION.Story_ID = STORY.Title
GROUP BY PUBLISHER.PublisherName;

select distinct ImprintName from PUBLISHER_IMPRINT;

-- Counting the amount of books published under a publisher, and their imprint (*) (Agg)
SELECT PUBLISHER.PublisherName, PUBLISHER_IMPRINT.ImprintName, COUNT(STORY.Title) AS BooksPublished
FROM PUBLISHER
LEFT JOIN PUBLISHER_IMPRINT ON PUBLISHER.PUBLISHER_ID = PUBLISHER_IMPRINT.PUBLISHER_ID
LEFT JOIN EDITION ON PUBLISHER_IMPRINT.PUBLISHER_IMPRINT_ID = EDITION.Publication_ID
LEFT JOIN STORY ON EDITION.Story_ID = STORY.Title
GROUP BY PUBLISHER.PublisherName, PUBLISHER_IMPRINT.ImprintName;

-- listing books, publisher name and imprint

SELECT PUBLISHER_IMPRINT.ImprintName, PUBLISHER.PublisherName, STORY.Title
FROM PUBLISHER_IMPRINT
JOIN PUBLISHER ON PUBLISHER_IMPRINT.PUBLISHER_ID = PUBLISHER.PUBLISHER_ID
JOIN EDITION ON PUBLISHER_IMPRINT.PUBLISHER_IMPRINT_ID = EDITION.Publication_ID
JOIN STORY ON EDITION.Story_ID = STORY.Title;

select * from EDITION;

-- Total amount of Books we have in a database under a certain subseries (Agg) (*)

SELECT STORY.Subseries, COUNT(STORY.Title) AS TotalBooksPublished
FROM STORY
GROUP BY STORY.Subseries
ORDER BY TotalBooksPublished DESC;

-- Group Book by subseries
SELECT STORY.Subseries, COUNT(STORY.Title) AS TotalBooks, AVG(EDITION.PublicationYear) AS AveragePublicationYear, DIMENSIONS.BookFormat AS AverageBookFormat
FROM STORY
LEFT JOIN EDITION ON STORY.Title = EDITION.Story_ID
LEFT JOIN EDITION_DIMENSION ON EDITION.Edition_ID = EDITION_DIMENSION.Edition_ID
LEFT JOIN DIMENSIONS ON EDITION_DIMENSION.Dimensions_ID = DIMENSIONS.Dimensions_ID
GROUP BY STORY.Subseries, DIMENSIONS.BookFormat
ORDER BY TotalBooks DESC;


-- Listing the Books, Cover Art and Cover Artist

SELECT STORY.Title, COVER_ART.Cover, CONCAT(COVER_ARTIST.ArtFirstName, ' ', COVER_ARTIST.ArtLastName) AS CoverArtist
FROM STORY
LEFT JOIN COVER_ART ON STORY.Title = COVER_ART.Story_ID
LEFT JOIN COVER_ARTIST ON COVER_ART.Cover_Artist_ID = COVER_ARTIST.Cover_Artist_ID;


-- Listing Book, Cover Art, Format (Non Agg) (*)

SELECT STORY.Title, CONCAT(COVER_ARTIST.ArtFirstName, ' ', COVER_ARTIST.ArtLastName) AS CoverArtist, DIMENSIONS.BookFormat, COVER_ART.Cover
FROM STORY
JOIN EDITION ON STORY.Title = EDITION.Story_ID
JOIN COVER_ART ON EDITION.Cover_Art_ID = COVER_ART.Cover_Art_ID
JOIN COVER_ARTIST ON COVER_ART.Cover_Artist_ID = COVER_ARTIST.Cover_Artist_ID
JOIN EDITION_DIMENSION ON EDITION.Edition_ID = EDITION_DIMENSION.Edition_ID
JOIN DIMENSIONS ON EDITION_DIMENSION.Dimensions_ID = DIMENSIONS.Dimensions_ID;

-- List book title, edition and dimensions (Non Agg) (*)

SELECT STORY.Title, EDITION.Edition_ID, SIZE.Height, SIZE.Width, SIZE.Pages
FROM STORY
JOIN EDITION ON STORY.Title = EDITION.Story_ID
JOIN EDITION_DIMENSION ON EDITION.Edition_ID = EDITION_DIMENSION.Edition_ID
JOIN DIMENSIONS ON EDITION_DIMENSION.Dimensions_ID = DIMENSIONS.Dimensions_ID
JOIN SIZE ON DIMENSIONS.Size_ID = SIZE.Size_ID;

SELECT STORY.Title, CASE WHEN EDITION.FirstEd = 1 THEN 'Yes' ELSE 'No' END AS IsFirstEdition, SIZE.Height, SIZE.Width, SIZE.Pages
FROM STORY
INNER JOIN EDITION ON STORY.Title = EDITION.Story_ID
INNER JOIN EDITION_DIMENSION ON EDITION.Edition_ID = EDITION_DIMENSION.Edition_ID
INNER JOIN DIMENSIONS ON EDITION_DIMENSION.Dimensions_ID = DIMENSIONS.Dimensions_ID
INNER JOIN SIZE ON DIMENSIONS.Size_ID = SIZE.Size_ID;

select * from SIZE;
select * from EDITION;
select * from DIMENSIONs;
select * from EDITION_DIMENSION;






SELECT  COUNT(STORY.Title) AS BooksPublished, PUBLISHER.PublisherName, PUBLISHER_IMPRINT.ImprintName
FROM PUBLISHER
LEFT JOIN PUBLISHER_IMPRINT ON PUBLISHER.PUBLISHER_ID = PUBLISHER_IMPRINT.PUBLISHER_ID
LEFT JOIN EDITION ON PUBLISHER_IMPRINT.PUBLISHER_IMPRINT_ID = EDITION.Publication_ID
LEFT JOIN STORY ON EDITION.Story_ID = STORY.Title
GROUP BY PUBLISHER.PublisherName, PUBLISHER_IMPRINT.ImprintName;

SELECT COUNT(Story.Title) FROM Story;








-- Publisher. PublisherName, Publisher_Imprint.Imprint Name, Story.Title
-- Publisher, PublisherImprint, Story -> Edition -> Publication

-- No audio book imprints here
SELECT COUNT(STORY.Title) AS BooksPublished, PUBLISHER.PublisherName, PUBLISHER_IMPRINT.ImprintName
FROM PUBLISHER, PUBLISHER_IMPRINT, STORY, EDITION, PUBLICATION
WHERE PUBLISHER.PUBLISHER_ID = PUBLISHER_IMPRINT.PUBLISHER_ID
AND PUBLISHER_IMPRINT.PUBLISHER_IMPRINT_ID = PUBLICATION.PUBLISHER_IMPRINT_ID
AND PUBLICATION.PUBLICATION_ID = EDITION.Publication_ID
AND EDITION.Story_ID = STORY.Title
GROUP BY PUBLISHER.PublisherName, PUBLISHER_IMPRINT.ImprintName;















SELECT PUBLISHER.PublisherName, PUBLISHER_IMPRINT.ImprintName, PUBLISHER_IMPRINT.PUBLISHER_IMPRINT_ID, COUNT(STORY.Title) AS BooksPublished
FROM PUBLISHER
INNER JOIN PUBLISHER_IMPRINT ON PUBLISHER.PUBLISHER_ID = PUBLISHER_IMPRINT.PUBLISHER_ID
LEFT JOIN PUBLICATION ON PUBLISHER_IMPRINT.PUBLISHER_IMPRINT_ID = PUBLICATION.PUBLISHER_IMPRINT_ID
LEFT JOIN EDITION ON PUBLICATION.PUBLICATION_ID = EDITION.Publication_ID
LEFT JOIN STORY ON EDITION.Story_ID = STORY.Title
GROUP BY PUBLISHER.PublisherName, PUBLISHER_IMPRINT.ImprintName, PUBLISHER_IMPRINT.PUBLISHER_IMPRINT_ID;










-- Audio book imprints but count is 0
SELECT COUNT(DISTINCT STORY.Title) AS BooksPublished, PUBLISHER.PublisherName, PUBLISHER_IMPRINT.ImprintName
FROM PUBLISHER
INNER JOIN PUBLISHER_IMPRINT ON PUBLISHER.PUBLISHER_ID = PUBLISHER_IMPRINT.PUBLISHER_ID
INNER JOIN PUBLICATION ON PUBLISHER_IMPRINT.PUBLISHER_IMPRINT_ID = PUBLICATION.PUBLISHER_IMPRINT_ID
LEFT JOIN EDITION ON PUBLICATION.PUBLICATION_ID = EDITION.Publication_ID
LEFT JOIN STORY ON EDITION.Story_ID = STORY.Title
GROUP BY PUBLISHER.PublisherName, PUBLISHER_IMPRINT.ImprintName;










SELECT COUNT(STORY.Title) AS BooksPublished, PUBLISHER.PublisherName, PUBLISHER_IMPRINT.ImprintName
FROM PUBLISHER
INNER JOIN PUBLISHER_IMPRINT ON PUBLISHER.PUBLISHER_ID = PUBLISHER_IMPRINT.PUBLISHER_ID
INNER JOIN PUBLICATION ON PUBLISHER_IMPRINT.PUBLISHER_IMPRINT_ID = PUBLICATION.PUBLISHER_IMPRINT_ID
LEFT JOIN EDITION ON PUBLICATION.PUBLICATION_ID = EDITION.Publication_ID
LEFT JOIN STORY ON EDITION.Story_ID = STORY.Title
GROUP BY PUBLISHER.PublisherName, PUBLISHER_IMPRINT.ImprintName;


select * from edition;
select * from publisher;
select * from publication;
select * from publisher_imprint;








-- tried counting both to add them together but that just adds on top of the books
SELECT
    COUNT(DISTINCT STORY.Title) + COUNT(DISTINCT AUDIO_BOOK.STORY_ID) AS BooksPublished, PUBLISHER.PublisherName, PUBLISHER_IMPRINT.ImprintName
FROM PUBLISHER
INNER JOIN PUBLISHER_IMPRINT ON PUBLISHER.PUBLISHER_ID = PUBLISHER_IMPRINT.PUBLISHER_ID
INNER JOIN PUBLICATION ON PUBLISHER_IMPRINT.PUBLISHER_IMPRINT_ID = PUBLICATION.PUBLISHER_IMPRINT_ID
LEFT JOIN EDITION ON PUBLICATION.PUBLICATION_ID = EDITION.Publication_ID
LEFT JOIN STORY ON EDITION.Story_ID = STORY.Title
LEFT JOIN AUDIO_BOOK ON PUBLICATION.PUBLICATION_ID = AUDIO_BOOK.PUBLICATION_ID
GROUP BY PUBLISHER.PublisherName, PUBLISHER_IMPRINT.ImprintName;




SELECT
    COUNT(DISTINCT STORY.Title) AS BooksPublished,
    PUBLISHER.PublisherName,
    PUBLISHER_IMPRINT.ImprintName
FROM
    PUBLISHER
INNER JOIN PUBLISHER_IMPRINT ON PUBLISHER.PUBLISHER_ID = PUBLISHER_IMPRINT.PUBLISHER_ID
LEFT JOIN PUBLICATION ON PUBLISHER_IMPRINT.PUBLISHER_IMPRINT_ID = PUBLICATION.PUBLISHER_IMPRINT_ID
LEFT JOIN EDITION ON PUBLICATION.PUBLICATION_ID = EDITION.Publication_ID
LEFT JOIN STORY ON EDITION.Story_ID = STORY.Title
GROUP BY PUBLISHER.PublisherName, PUBLISHER_IMPRINT.ImprintName;


-- Count distinct stories
SELECT COUNT(DISTINCT Title) AS StoryCount FROM STORY;

-- Count distinct audio books
SELECT COUNT(STORY_ID) AS AudioBookCount FROM AUDIO_BOOK;


SELECT
    AUDIO_BOOK.STORY_ID AS BookTitle,
    PUBLISHER.PublisherName,
    PUBLISHER_IMPRINT.ImprintName
FROM
    AUDIO_BOOK
LEFT JOIN PUBLICATION ON AUDIO_BOOK.PUBLICATION_ID = PUBLICATION.PUBLICATION_ID
LEFT JOIN PUBLISHER_IMPRINT ON PUBLICATION.PUBLISHER_IMPRINT_ID = PUBLISHER_IMPRINT.PUBLISHER_IMPRINT_ID
LEFT JOIN PUBLISHER ON PUBLISHER_IMPRINT.PUBLISHER_ID = PUBLISHER.PUBLISHER_ID;



/*Just books*/
select count(edition_dimension.bookisbn) as BooksPublished, PUBLISHER.PublisherName, PUBLISHER_IMPRINT.ImprintName
		from PUBLISHER, publisher_imprint, publication, edition, edition_dimension
		where PUBLISHER_IMPRINT.PUBLISHER_ID = PUBLISHER.PUBLISHER_ID
		and PUBLICATION.PUBLISHER_IMPRINT_ID = PUBLISHER_IMPRINT.PUBLISHER_IMPRINT_ID
		and publication.publication_id = EDITION.Publication_ID
		and edition_dimension.edition_ID = edition.edition_ID
		GROUP BY PUBLISHER.PublisherName, PUBLISHER_IMPRINT.ImprintName
		order by PUBLISHER.PublisherName asc;
 
 /*Just audiobooks*/
select count(distinct audio_format.audioisbn), PUBLISHER.PublisherName, PUBLISHER_IMPRINT.ImprintName
			from PUBLISHER, publisher_imprint, publication, audio_book, audio_format
			where PUBLISHER_IMPRINT.PUBLISHER_ID = PUBLISHER.PUBLISHER_ID
			and PUBLICATION.PUBLISHER_IMPRINT_ID = PUBLISHER_IMPRINT.PUBLISHER_IMPRINT_ID
			and publication.publication_id = audio_book.publication_id
			and audio_format.audio_book_id = audio_book.audio_book_id
			GROUP BY PUBLISHER.PublisherName, PUBLISHER_IMPRINT.ImprintName
            order by PUBLISHER.PublisherName asc;

/*The unholy mess that is my attempt to combine the two*/
select count(num) as total, PUBLISHER.PublisherName, PUBLISHER_IMPRINT.ImprintName
from PUBLISHER, publisher_imprint,
		(select count(distinct edition_dimension.bookisbn) as num, PUBLISHER.PublisherName, PUBLISHER_IMPRINT.ImprintName
			from PUBLISHER, publisher_imprint, publication, edition, edition_dimension
			where PUBLISHER_IMPRINT.PUBLISHER_ID = PUBLISHER.PUBLISHER_ID
			and PUBLICATION.PUBLISHER_IMPRINT_ID = PUBLISHER_IMPRINT.PUBLISHER_IMPRINT_ID
			and publication.publication_id = EDITION.Publication_ID
			and edition_dimension.edition_ID = edition.edition_ID
			GROUP BY PUBLISHER.PublisherName, PUBLISHER_IMPRINT.ImprintName
	union all
		select count(distinct audio_format.audioisbn) as num, PUBLISHER.PublisherName, PUBLISHER_IMPRINT.ImprintName
			from PUBLISHER, publisher_imprint, publication, audio_book, audio_format
			where PUBLISHER_IMPRINT.PUBLISHER_ID = PUBLISHER.PUBLISHER_ID
			and PUBLICATION.PUBLISHER_IMPRINT_ID = PUBLISHER_IMPRINT.PUBLISHER_IMPRINT_ID
			and publication.publication_id = audio_book.publication_id
			and audio_format.audio_book_id = audio_book.audio_book_id
			GROUP BY PUBLISHER.PublisherName, PUBLISHER_IMPRINT.ImprintName) as ex
    GROUP BY PUBLISHER.PublisherName, PUBLISHER_IMPRINT.ImprintName;




