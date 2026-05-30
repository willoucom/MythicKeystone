local myname, ns = ...

local L = LibStub("AceLocale-3.0"):NewLocale(myname, "ruRU")
if not L then return end

-- Guide UI strings
L["GUIDE_back_btn"]         = "Назад к списку"
L["GUIDE_coming_soon"]      = "(Скоро)"
L["GUIDE_wip"]              = "Руководство для этого подземелья пишется."
L["GUIDE_s1_header"]        = "Подземелья 'Полночи' - 1-й сезон"
L["GUIDE_other_dungeons"]   = "Другие подземелья"
L["GUIDE_tooltip_click"]    = "ЛКМ: открыть/закрыть"
L["GUIDE_tooltip_drag"]     = "Перетаскивание: переместить кнопку"
L["GUIDE_vignette_tooltip"] = "Открыть руководство по подземелью"
L["GUIDE_portal_tooltip"]   = "Телепортироваться в это подземелье"

-- About popup
L["ABOUT_btn_tooltip"]        = "Об этом аддоне"
L["ABOUT_title"]              = "О Mythic Dungeon Notes"
L["ABOUT_author"]             = "Автор: Willou"
L["ABOUT_description"]        = "Все стратегии для подземелий и заметки к боссам, в игре и в один клик."
L["ABOUT_mk_header"]          = "Также загляните в MythicKeystone"
L["ABOUT_mk_pitch"]           = "Ваши ключи, ключи Ваших альтов, ключи Вашей группы и ключи Вашей гильдии - всё собрано во фрейме поиска группы (LFG), в реальном времени."
L["ABOUT_mk_feature_alts"]    = "• Альты - все Ваши ключи под рукой"
L["ABOUT_mk_feature_party"]   = "• Группа - проверьте ключи группы перед входом"
L["ABOUT_mk_feature_guild"]   = "• Гильдия - ключи, сгруппированные по подземельям"
L["ABOUT_mk_feature_auto"]    = "• Автовставка - вставляет Ваш ключ, с проверкой готовности и обратным отсчётом"
L["ABOUT_mk_companion"]       = "Также доступен компаньон LibDataBroker для Titan Panel и аналогичных панелей."
L["ABOUT_links_header"]       = "Ссылки"
L["ABOUT_link_curseforge"]    = "CurseForge"
L["ABOUT_link_wago"]          = "Wago"
L["ABOUT_link_github"]        = "GitHub"
L["ABOUT_url_popup_text"]     = "Скопируйте этот URL с помощью Ctrl+C:"

-- Common section labels
L["COMMON_intro_label"]       = "Введение"
L["COMMON_notable_trash"]     = "Важный треш"
L["COMMON_cc_immune"]         = "• Иммунитет к контролю"

-------------------------------------------------------------------------------
-- Midnight — Legacy Dungeons (S1)
-------------------------------------------------------------------------------

-- Algeth'ar Academy (AA) — uiMapId 2097
L["AA_name"]              = "Академия Алгет'ар"
L["AA_entrance_label"]    = "Вход"
L["AA_entrance_intro"]    = "Академия Алгет'ар - Драконы, Драконьи Острова."
L["AA_entrance_bosses"]   = "4 босса: Заросшее древо -> Кроут -> Вексам -> Эхо Дорагосы."
L["AA_entrance_desc"]     = "Каждый учитель даёт бафф в зависимости от своего драконьего полёта."
L["AA_bronze_drake_desc"] = "Бронзовая вербовщица"
L["AA_bronze_drake"]      = "+5% к скорости"
L["AA_red_drake_desc"]    = "Красная вербовщица"
L["AA_red_drake"]         = "+5% к универсальности"
L["AA_green_drake_desc"]  = "Зеленый вербовщик"
L["AA_green_drake"]       = "+10% получаемого лечения"
L["AA_blue_drake_desc"]   = "Синяя вербовщица"
L["AA_blue_drake"]        = "Искусность (584 ед.)"
L["AA_black_drake_desc"]  = "Черный вербовщик"
L["AA_black_drake"]       = "+5% к крит. удару"

-- Section names
L["AA_boss1"]             = "Первый босс: Заросшее древо"
L["AA_boss2"]             = "Второй босс: Кроут"
L["AA_boss3"]             = "Третий босс: Вексам"
L["AA_boss4"]             = "Четвёртый босс: Эхо Дорагосы"
L["AA_trash_label"]       = "Трэш"

-- Mob names
L["AA_boss1_name"]        = "Заросшее древо"
L["AA_boss1_branch_name"] = "Ветвь древня"
L["AA_boss2_name"]        = "Кроут"
L["AA_boss3_name"]        = "Вексам"
L["AA_boss4_name"]        = "Эхо Дорагосы"
L["AA_trash1_mob1_name"]  = "Мерзкий плеточник"
L["AA_trash1_mob2_name"]  = "Рассерженная стрекотуха"
L["AA_trash2_mob1_name"]  = "Охранник"
L["AA_trash2_mob2_name"]  = "Орел-вожак"
L["AA_trash3_mob1_name"]  = "Оскверненный манадемон"
L["AA_trash3_mob2_name"]  = "Зачарованный боевой топор"
L["AA_trash3_mob3_name"]  = "Свирепый опустошитель"
L["AA_trash3_mob4_name"]  = "Чародейский добытчик"
L["AA_trash3_mob5_name"]  = "Хаотичный учебник"
L["AA_trash4_mob1_name"]  = "Алгет'арский рыцарь эха"
L["AA_trash4_mob2_name"]  = "Алгет'арская заклинательница"

-- Descriptions — Trash 1
L["AA_trash1_mob1_desc1"] = "• %s - нацеливается на танка; следите за стаками, используйте защитные способности или снимайте кровотечение при необходимости."
L["AA_trash1_mob1_desc2"] = "• %s - создаёт вихрь под каждым игроком, уклоняйтесь от него."
L["AA_trash1_mob2_desc1"] = "Держитесь группой, чтобы эффективно расправляться с этими мобами."
L["AA_trash1_mob2_desc2"] = "По возможности усмиряйте их."
L["AA_trash1_mob2_desc3"] = "• Танк должен следить за стаками %s."
L["AA_trash1_mob2_desc4"] = "• %s - нацеливается на случайного игрока."

-- Descriptions — Boss 1
L["AA_boss1_desc0"]       = "Держитесь как можно более сгруппированно на танке."
L["AA_boss1_desc1"]       = "Остерегайтесь %s: медленно двигайтесь по кругу влево, оставаясь в группе."
L["AA_boss1_desc2"]       = "• При достижении 100 ед. энергии босс применяет %s и призывает |cff44FF44Ветвь древня|r."
L["AA_boss1_desc3"]       = "• Всегда прерывайте его лечащее заклинание %s."
L["AA_boss1_desc4"]       = "• После смерти |cff44FF44Ветвь древня|r оставляет %s (зелёный круг на земле), который удаляет %s, если Вы заходите внутрь."

-- Descriptions — Trash 2
L["AA_trash2_mob1_desc1"] = "• %s - нацеливается на танка, используйте защитную способность."
L["AA_trash2_mob1_desc2"] = "• %s - нацеливается на случайного игрока и создаёт торнадо, которого нужно избегать."
L["AA_trash2_mob1_desc3"] = "• %s - AoE, выбегайте из неё или используйте поле зрения."
L["AA_trash2_mob2_desc1"] = "• %s - фронтальная способность, направленная на случайную цель, уклоняйтесь, иначе можете упасть."

-- Descriptions — Boss 2
L["AA_boss2_desc0"]       = "• Танк должен иметь активную защитную способность под каждый удар %s и под его периодический урон."
L["AA_boss2_desc0b"]      = "Примечание: в 'Полночи' этот эффект не считается кровотечением."
L["AA_boss2_desc1"]       = "• Рассредоточьтесь и прекратите все произнесения заклинаний во время %s."
L["AA_boss2_desc2"]       = "• На 75% и 45% бросьте все три мяча в одном направлении."

-- Descriptions — Trash 3
L["AA_trash3_mob1_desc1"] = "• %s - нацеливается на случайного игрока, нужно прерывать это."
L["AA_trash3_mob1_desc2"] = "• %s - нацеливается на случайного игрока; не стойте кучно, при необходимости используйте защитную способность."
L["AA_trash3_mob2_desc1"] = "• Танку следует знать, что эти мобы наносят пассивный бонусный урон тайной магией через бафф %s."
L["AA_trash3_mob3_desc1"] = "• %s - атакует самого дальнего игрока; используйте защитную способность и держитесь группой, чтобы легко расправляться с противниками."
L["AA_trash3_mob3_desc2"] = "• Сразу после атаки фронтальная способность %s направляется на танка: отойдите в сторону, чтобы избежать."
L["AA_trash3_mob4_desc1"] = "• %s - нацеливается на случайного игрока; следите за большим уроном в группах с несколькими такими мобами."
L["AA_trash3_mob5_desc1"] = "• %s - каст на случайном игроке; прерывайте, а если началось - используйте контроль или магическое развеивание."

-- Descriptions — Boss 3
L["AA_boss3_desc0"]       = "• %s - фронталка в танка: направьте её от группы и используйте защитную способность."
L["AA_boss3_desc1"]       = "• Поглощайте по одной %s за волну; сферы не должны достигать босса. Берите по одной на каждого."
L["AA_boss3_desc2"]       = "• %s создаёт ровно 3 зоны на земле; двигайтесь равномерно, чтобы избежать их, но не разбегайтесь по всей площадке."

-- Descriptions — Trash 4
L["AA_trash4_mob1_desc1"] = "• %s - AoE под случайным игроком, быстро уклоняйтесь."
L["AA_trash4_mob1_desc2"] = "• %s - сильный удар по рейду; следите за здоровьем и используйте защитные способности при необходимости."
L["AA_trash4_mob2_desc1"] = "• %s - дебафф на случайном игроке: высокий приоритет для прерывания."
L["AA_trash4_mob2_desc2"] = "• %s - нацеливается на случайного игрока, используйте доступные прерывания."

-- Descriptions — Boss 4
L["AA_boss4_desc0"]       = "Держите босса близко к стене, постепенно двигаясь, чтобы избежать луж."
L["AA_boss4_desc1"]       = "При пулле босс сразу же применяет %s."
L["AA_boss4_desc2"]       = "• Каждое попадание способностью даёт стак %s. При 3-х стаках под ногами игрока появляется %s - размещайте их вдоль стены."
L["AA_boss4_desc3"]       = "• %s периодически стреляют сферами %s, которых нужно избегать."
L["AA_boss4_desc4"]       = "• %s - нацеливается на случайного игрока: держитесь слегка рассредоточенно, используйте защитную способность (остерегайтесь %s - потенциально смертельная комбинация)."
L["AA_boss4_desc5"]       = "• %s - притягивает всех игроков к боссу: Бегите!"

-- The Seat of the Triumvirate (SOT) — uiMapId 903
L["SOT_name"]             = "Престол Триумвирата"
-- Intro
L["SOT_intro_desc1"]      = "Престол Триумвирата - Легион, Эредат (Аргус)."
L["SOT_intro_desc2"]      = "4 босса: Зураал Перерожденный -> Сарпиш -> Наместник Незжар -> Л'ура."
-- Notable Trash
L["SOT_trash1_name"]      = "Беспощадная подчинительница"
L["SOT_trash1_desc1"]     = "%s: нацеливается на всех игроков - слегка рассредоточьтесь, чтобы избежать урона от разлетающихся осколков. %s: поглощение на случайной цели - приоритетное лечение."
L["SOT_trash2_name"]      = "Темная кудесница"
L["SOT_trash2_desc1"]     = "%s: прерывайте каждый раз без исключения. %s: вторичная цель для прерывания."
L["SOT_trash3_name"]      = "Страж прорыва"
L["SOT_trash3_desc1"]     = "%s: всегда оставайтесь в радиусе 30 ярдов - иначе смертельный взрыв. %s: магический дебафф на случайных игроках - развеивайте. %s: массовый урон по группе с кругами, которых нужно избегать."
L["SOT_trash4_name"]      = "Защитница из Темной Стражи"
L["SOT_trash4_desc1"]     = "%s: получает опасные стаки, если никого нет в ближнем бою - постоянно держите контакт. %s: ярость - усмиряйте или используйте защитные способности танка."
L["SOT_trash5_name"]      = "Лютая заклинательница Бездны"
L["SOT_trash5_desc1"]     = "%s: мощный бафф - немедленно прерывайте или развеивайте."
-- Boss 1: Zuraal the Ascended
L["SOT_boss1_name"]       = "Зураал Перерожденный"
L["SOT_boss1_desc1"]      = "%s: накладывает периодический урон и призывает два Сгустка Бездны, которые взрываются при контакте с боссом. %s: ускоряет их и притягивает игроков - немедленно отойдите и убейте аддов до того, как они достигнут босса."
L["SOT_boss1_desc2"]      = "%s: прыгает на случайного игрока, оставляя лужу - отойдите. %s: опасно для танка - используйте защитную способность. %s: фронтальная способность на случайную цель - уклоняйтесь."
-- Boss 2: Saprish
L["SOT_boss2_name"]       = "Сарпиш"
L["SOT_boss2_desc1"]      = "%s: массовый урон по группе с периодическим уроном - будьте с полным здоровьем перед применением. %s: рывок, создающий круги для взрыва %s бомб - уклоняйтесь от оставшихся бомб."
L["SOT_boss2_desc2"]      = "%s: способность Черноклыка, требующая два прерывания - часто накладывается на 'Фазовый рывок'. %s: урон по случайной цели от Черноклыка."
-- Boss 3: Viceroy Nezhar
L["SOT_boss3_name"]       = "Наместник Незжар"
L["SOT_boss3_desc1"]      = "%s: призывает 3 врат, генерирующих %s - оставайтесь мобильными и предугадывайте траектории. %s: двигайтесь к боссу во время каста, чтобы снизить урон по группе."
L["SOT_boss3_desc2"]      = "%s: призывает 5 аддов, кастующих 'Пытка разума' - быстро убивайте их с помощью АоЕ урона. %s: нацеливается на танка - организуйте ротацию прерываний. %s: нацеливается на 3-х игроков - используйте защитные способности."
-- Boss 4: L'ura
L["SOT_boss4_name"]       = "Л'ура"
L["SOT_boss4_desc1"]      = "%s: удар по группе, призывающий шесть нот отчаяния. %s: каждая активная нота накладывает стак каждые 2 секунды - используйте %s, чтобы заставить их замолчать при появлении с помощью %s."
L["SOT_boss4_desc2"]      = "%s: перемещает ноты и накладывает стаки 'Страдания' - сначала заставьте ноты замолчать. %s: вращающиеся лучи - постоянно двигайтесь."
L["SOT_boss4_desc3"]      = "%s: накапливающийся дебафф на танке - при 3-х стаках вызывает мощный удар тенью; используйте защитную способность или поверните босса. %s: дебафф босса во время переходной фазы - сохраните кулдауны для этой фазы."

-- Skyreach (SKY) — uiMapId 601/602
L["SKY_name"]             = "Небесный Путь"
-- Intro
L["SKY_intro_desc1"]      = "Небесный Путь - Дренор, Араккоа."
L["SKY_intro_desc2"]      = "4 босса: Ранжит -> Аракнат -> Рухран -> Высший мудрец Вирикс."
-- Notable Trash
L["SKY_trash1_name"]      = "Парящий мастер шакрама"
L["SKY_trash1_desc1"]     = "%s: шакрам, отскакивающий между ближайшими игроками - рассредоточьтесь в стороны от союзников, чтобы ограничить количество отскоков."
L["SKY_trash2_name"]      = "Жрица Слепящего солнца"
L["SKY_trash2_desc1"]     = "%s: прерывайте без исключений. %s: бафф на себя - немедленно снимайте."
L["SKY_trash3_name"]      = "Когтекрыл-ветеран"
L["SKY_trash3_desc1"]     = "%s: рывок, нацеленный на танка и 2-х случайных игроков, оставляет физическое кровотечение на 6 сек. - развеивание кровотечения (Натурализация у пробудителя) снимает его. %s: опасно для танка - используйте защитную способность."
L["SKY_trash4_name"]      = "Неистовый призыватель бури"
L["SKY_trash4_desc1"]     = "%s: прерывайте для предотвращения группового отбрасывания."
L["SKY_trash5_name"]      = "Солнечный элементаль"
L["SKY_trash5_desc1"]     = "%s: призывает Солнечные сферы - приоритетное убийство, чтобы избежать %s (огненных кругов)."
L["SKY_trash6_name"]      = "Грозный ворон"
L["SKY_trash6_desc1"]     = "%s: AoE-отбрасывание - встаньте спиной к стене. %s: высокий урон - используйте защитные способности."
-- Boss 1: Ranjit
L["SKY_boss1_name"]       = "Ранжит"
L["SKY_boss1_desc1"]      = "%s: создаёт ветряные сферы с отбрасыванием - сбрасывайте сферы за пределами траектории движения группы. %s: призывает торнадо - двигайтесь чаще."
L["SKY_boss1_desc2"]      = "%s: накладывает кровотечение на всю группу - используйте лечащие кулдауны. %s: снаряд в сторону случайного игрока, который возвращается к боссу - двигайтесь в сторону, чтобы избежать его."
-- Boss 2: Araknath
L["SKY_boss2_name"]       = "Аракнат"
L["SKY_boss2_desc1"]      = "%s: Малые големы посылают лучи к боссу группами по 3 - убейте их до того, как они достигнут босса, иначе %s наносит массовый урон по группе."
L["SKY_boss2_desc2"]      = "%s: можно избежать, если танк постоянно находится в ближнем бою. %s: AoE радиусом 5 ярдов под боссом - никогда не стойте там. %s: линейная атака - танк позиционируется перпендикулярно группе."
-- Boss 3: Rukhran
L["SKY_boss3_name"]       = "Рухран"
L["SKY_boss3_desc1"]      = "%s: призывает Солнцекрылов - переключитесь на убийство аддов. %s: фиксируется на игроке с пульсациями - этот игрок отходит от группы."
L["SKY_boss3_desc2"]      = "%s: прячьтесь за центральной колонной, чтобы заблокировать снаряды. %s: опасно для танка - защитная способность под каждое применение. %s: применяется, если танк выходит из ближнего боя - оставайтесь в ближнем бою."
-- Boss 4: High Sage Viryx
L["SKY_boss4_name"]       = "Высший мудрец Вирикс"
L["SKY_boss4_desc1"]      = "%s: поддерживайте ротацию прерываний. %s: нацеливается на 3-х игроков - рассредоточьтесь, чтобы снизить урон по области."
L["SKY_boss4_desc2"]      = "%s: стаскивает случайного игрока с платформы - немедленно возвращайтесь по боковой дорожке. %s: преследующий луч, оставляющий огненный след - бегайте по кругу, чтобы не перекрывать область."

-- Pit of Saron (POS) — uiMapId 184
L["POS_name"]             = "Яма Сарона"
-- Intro
L["POS_intro_desc1"]      = "Яма Сарона - Гнев Короля-лича, Ледяная Корона."
L["POS_intro_desc2"]      = "3 босса: Начальник кузни Гархлад -> Ик и Крик -> Повелитель Плети Тираний."
L["POS_intro_desc3"]      = "Перед третьим боссом Вас ждёт испытание от Верного льдам генерала"
-- Notable Trash
L["POS_trash1_name"]      = "Лич-страхогон"
L["POS_trash1_desc1"]     = "%s: применение, нацеленное на танка - прерывайте, очень высокий урон. %s: срабатывает при 50%% здоровья, пульсация каждые 2 секунды - групповые кулдауны. %s: случайная цель - используйте защитную способность."
L["POS_trash2_name"]      = "Некролит из свиты Леди"
L["POS_trash2_desc1"]     = "%s: прислужники неуязвимы, пока жив Некролит - сначала сосредоточьтесь на заклинателе. %s: бафф на случайном прислужнике - развеивайте."
L["POS_trash3_name"]      = "Труп чародея"
L["POS_trash3_desc1"]     = "%s: большая AoE, требующая прерывания - высокий приоритет."
L["POS_trash4_name"]      = "Неуклюжее чумное чудовищеr"
L["POS_trash4_desc1"]     = "%s: ярость - усмиряйте. %s: создаёт периодические лужи - держите зону боя чистой."
L["POS_trash5_name"]      = "Снежнокостный хладный дух"
L["POS_trash5_desc1"]     = "%s: прерываемое заклинание. %s: дебафф на 2-х игроках - развеивайте или используйте эффект свободы."
L["POS_trash6_name"]      = "Ледникор (мини-босс)"
L["POS_trash6_desc1"]     = "%s: AoE по всей группе - рассредоточьтесь и уводите моба. %s: направленный щит - встаньте за спину мобу, чтобы гарантированно наносить критические удары."
L["POS_trash7_name"]      = "Истязатель из каменоломни и Грозный каратель"
L["POS_trash7_desc1"]     = "%s: проклятие на случайной цели - развеивайте. %s: накапливающийся дебафф на танке - следите за счётчиком."
-- Boss 1: Forgemaster Garfrost
L["POS_boss1_name"]       = "Начальник кузни Гархлад"
L["POS_boss1_desc1"]      = "%s: создаёт опасные лужи на земле, нацеливаясь на 2-х игроков - отойдите и уничтожайте куски руды, чтобы очистить область."
L["POS_boss1_desc2"]      = "%s: танк должен разбивать ближайшие куски руды, чтобы избежать оглушения."
L["POS_boss1_desc3"]      = "%s: босс нацеливается в сторону ближайшей печи - укройтесь за оставшимся куском руды, чтобы снизить урон."
L["POS_boss1_desc4"]      = "%s: уничтожает кусок руды и накладывает магический дебафф на 2-х игроков. %s: пассивный урон босса увеличивается с количеством активных магических дебаффов - развеивайте быстро."
-- Boss 2: Ick & Krick
L["POS_boss2_name"]       = "Ик и Крик"
L["POS_boss2_desc1"]      = "%s: оба босса имеют общий запас здоровья - достаточно фокусироваться на одном."
L["POS_boss2_desc2"]      = "%s: призывает 2 тени, несущих %s, проклятие на случайных целях - немедленно развеивайте."
L["POS_boss2_desc3"]      = "%s: прерываемое заклинание Крика - держите прерывание наготове. %s: удар по танку, создающий лужу - отведите босса с лужи."
L["POS_boss2_desc4"]      = "%s: создаёт лужи под 4-мя случайными игроками - рассредоточьтесь. %s: фиксируется на случайном игроке на 7 сек. - этот игрок отходит; группа помогает справиться с Иком."
-- Boss 3: Scourgelord Tyrannus
L["POS_boss3_name"]       = "Повелитель Плети Тираний"
L["POS_boss3_desc1"]      = "%s: отбрасывание танка с последующей прыжковой атакой - используйте защитную способность и готовьтесь к перемещению. %s и %s: круги на земле и касты - постоянно двигайтесь."
L["POS_boss3_desc2"]      = "%s: активирует %s костяных куч, которые призывают Гнильцов и Распространителей чумы. %s: Гнильцы накладывают стаки болезни на танка - используйте защитные способности. %s: прерываемое заклинание Распространителя чумы - приоритет для прерывания. %s: атакуйте ближайшие костяные кучи, чтобы снизить урон."

-------------------------------------------------------------------------------
-- Midnight — New Dungeons (S1)
-------------------------------------------------------------------------------

-- The Blinding Vale (BV) — uiMapId 2500
L["BV_name"]              = "The Blinding Vale"

-- Den of Nalorakk (DN) — uiMapId 2513
L["DN_name"]              = "Den of Nalorakk"
L["DN_intro_label"]       = "Introduction"
L["DN_intro_desc1"]       = "Den of Nalorakk — New dungeon, Midnight Season 2."
L["DN_intro_desc2"]       = "3 bosses: The Hoardmonger -> Sentinel of Winter -> Nalorakk."
L["DN_incense_label"]     = "Warding Incense"
L["DN_incense_desc"]      = "A Warding Incense brazier is located near the dungeon entrance."
L["DN_buff_alchemy_desc"] = "Midnight Alchemists (skill 25) and Bear Form Druids can burn incense: +1% Versatility for 10 minutes for the whole party."
-- Notable Trash
L["DN_trash_label"]       = "Notable Trash"
L["DN_trash_todo"]        = "TODO: list notable Amani trash (Beasthandlers, Frost Loa Initiates, patrolling Wind Serpents) and their key abilities."
-- Boss names (used as section titles)
L["DN_boss1"]             = "The Hoardmonger"
L["DN_boss2"]             = "Sentinel of Winter"
L["DN_boss3"]             = "Nalorakk"
-- Boss 1 — The Hoardmonger
L["DN_boss1_desc1"]       = "%s — At 90%%, 60%% and 30%% HP, the boss raids a resource pile and gains a new ability. On Mythic, every gained ability is kept until the end."
L["DN_boss1_desc2"]       = "%s — The boss tosses rotten food at random players (Nature damage) or seeds Rotten Mushrooms across the arena. Mushrooms detonate after 12s in a Putrid Burst, applying %s (stacking poison DoT). Soak only if needed and never in melee."
L["DN_boss1_desc3"]       = "%s — Frontal cone Nature slam. Stay out of his front; tank face the wall."
L["DN_boss1_desc4"]       = "%s — Raid-wide Physical roar that ignores armor. Use a personal or major raid CD on cast."
L["DN_boss1_desc5"]       = "Possible add-ons via Resourceful Measures: %s (more mushrooms), %s (frontal + lasting bone spikes that root), %s (raid burst + 8s bleeding DoT, ignores armor)."
-- Boss 2 — Sentinel of Winter
L["DN_boss2_desc1"]       = "%s — The boss splits ice into two icicles that splinter for Frost damage and reveal a Fractured Shivercore add. Spread targeted markers."
L["DN_boss2_desc2"]       = "%s — The Shivercore channels: interrupt it (Frost damage + stacking +10%% Frost taken for 20s). Kill the Shivercore quickly."
L["DN_boss2_desc3"]       = "%s — Wandering frost storms (1m30) that hit on impact and damage anyone within 2 yards. Dodge them all fight long."
L["DN_boss2_desc4"]       = "%s — Frost DoT every 2s for 16s. Dispellable — clear it on healers/DPS first."
L["DN_boss2_desc5"]       = "%s — At 100 energy, the Sentinel raises a frozen veil absorbing 15%% max HP that pushes everyone back and ticks Frost damage every second until broken. Burn it down ASAP, save big CDs."
L["DN_boss2_desc6"]       = "%s — On Shivercore death, a snowdrift spawns: -40%% movement speed but immune to forced movement. Use it to negate Eternal Winter knockbacks."
L["DN_boss2_desc7"]       = "Mythic: %s spawns ice shards landing after 6s — players must intercept them, otherwise %s roots the whole raid for 4s."
-- Boss 3 — Nalorakk
L["DN_boss3_intro"]       = "Zul'jarra (friendly NPC) fights alongside the group and interposes between the tank and Nalorakk. She alternates between two roles: shielding the tank from Onslaught while standing in front, and being targeted by Echoes that the group must intercept."
L["DN_boss3_desc1"]       = "%s — Nalorakk headbutts Zul'jarra into %s, then commands Echoes to charge her. Echoes hitting their first target inflict %s — DPS must intercept before they reach Zul'jarra."
L["DN_boss3_desc2"]       = "%s — Players are marked for 4s; an Echo then spawns at their location dealing Nature damage in 8 yards. Drop these away from the group."
L["DN_boss3_desc3"]       = "%s — Raid-wide Physical shout, ignores armor, 3s knockback. Use personals; position so the knockback doesn't push you into Echoes."
L["DN_boss3_desc4"]       = "%s — Tank takes repeated swipes over 4s, stacking damage taken. Move behind Zul'jarra to gain %s (-50%% damage from Onslaught)."
L["DN_boss3_desc5"]       = "Mythic: %s — Echoes apply a 20s stacking bleed on slashed players. Avoid Echo paths."

-- Magisters' Terrace (MT) — uiMapId 2520
L["MT_name"]              = "Magisters' Terrace"
L["MT_intro_label"]       = "Introduction"
L["MT_intro_desc1"]       = "Magisters' Terrace — New dungeon, Midnight Season 1."
L["MT_intro_desc2"]       = "4 bosses: Arcanotron Custos -> Seranel Sunlash -> Gemellus -> Degentrius."
L["MT_library_note"]      = "After defeating the first enemy in the library, a book appears on the lectern — click it to grant the group +5%% Haste for 30 minutes."
L["MT_trash_label"]       = "Notable Trash"
-- Boss names (used as section titles)
L["MT_boss1"]             = "Arcanotron Custos"
L["MT_boss2"]             = "Seranel Sunlash"
L["MT_boss3"]             = "Gemellus"
L["MT_boss4"]             = "Degentrius"
-- Notable Trash mob names
L["MT_trash_arcane_sentry_name"]      = "Arcane Sentry"
L["MT_trash_arcane_magister_name"]    = "Arcane Magister"
L["MT_trash_sunblade_name"]           = "Sunblade Enforcer"
L["MT_trash_lightward_name"]          = "Lightward Healer"
L["MT_trash_codex_name"]              = "Animated Codex"
L["MT_trash_pyromancer_name"]         = "Blazing Pyromancer"
L["MT_trash_familiar_name"]           = "Spellwoven Familiar"
L["MT_trash_wyrm_name"]               = "Brightscale Wyrm"
L["MT_trash_spellbreaker_name"]       = "Runed Spellbreaker"
L["MT_trash_voidling_name"]           = "Voidling"
L["MT_trash_shredder_name"]           = "Hollowsoul Shredder"
L["MT_trash_voidwalker_name"]         = "Dreaded Voidwalker"
L["MT_trash_voidcaller_name"]         = "Shadowrift Voidcaller"
L["MT_trash_unstable_name"]           = "Unstable Voidling"
L["MT_trash_void_infuser_name"]       = "Void Infuser"
L["MT_trash_tyrant_name"]             = "Devouring Tyrant"
-- Trash descriptions — Arcane Sentry
L["MT_trash_arcane_sentry_desc1"]     = "• %s — Targets the tank; use a root break or magic dispel to remove the effect."
L["MT_trash_arcane_sentry_desc2"]     = "• %s — Channel on a random player; avoid the pools it leaves on the ground."
L["MT_trash_arcane_sentry_desc3"]     = "• Monitor health and positioning during the AoE hit and knockback from %s."
-- Trash descriptions — Arcane Magister
L["MT_trash_arcane_magister_desc1"]   = "• %s — Random player target; high interrupt priority; if one goes through: magic dispel to remove it."
L["MT_trash_arcane_magister_desc2"]   = "• %s — Random player target; use available interrupts."
-- Trash descriptions — Sunblade Enforcer
L["MT_trash_sunblade_desc1"]          = "• The tank should monitor the magic buff %s and purge if possible; otherwise use a defensive to absorb the amplified strikes."
L["MT_trash_sunblade_desc2"]          = "• These mobs are difficult to kite as they use %s to close the gap."
-- Trash descriptions — Lightward Healer
L["MT_trash_lightward_desc1"]         = "• %s — Random player target; use a magic dispel to remove it."
L["MT_trash_lightward_desc2"]         = "• %s — Buffs a random ally; purge if possible."
-- Trash descriptions — Animated Codex
L["MT_trash_codex_desc1"]             = "• These mobs constantly pulse AoE damage via %s; don't pull too many at once and be ready with defensives or healing cooldowns."
-- Trash descriptions — Blazing Pyromancer
L["MT_trash_pyromancer_desc1"]        = "• |cffFF4444Interrupt|r every cast of %s without exception."
L["MT_trash_pyromancer_desc2"]        = "• Be ready with defensives or healing cooldowns when %s is active."
L["MT_trash_pyromancer_desc3"]        = "• Avoid the AoE hit and pool created by %s."
L["MT_trash_pyromancer_note"]         = "After the Pyromancer, the library door opens and the Librarians disappear. In the next courtyard, |cffFFD700Energy Crystals|r are scattered — interact with them to drain them and gain a temporary damage and healing bonus."
-- Trash descriptions — Spellwoven Familiar
L["MT_trash_familiar_desc1"]          = "• Beware the group AoE hit from %s, particularly dangerous when fighting other mobs that also deal AoE damage."
-- Trash descriptions — Brightscale Wyrm
L["MT_trash_wyrm_desc1"]              = "• Stagger the kills to avoid being overwhelmed by their death cast %s; stay close when they die to collect the stacking buff it applies."
-- Trash descriptions — Runed Spellbreaker
L["MT_trash_spellbreaker_desc1"]      = "• %s — Targets 2 random players; monitor HP if targeted and be ready to use defensives or health potions."
L["MT_trash_spellbreaker_desc2"]      = "• %s — Fires a line toward the tank; orient it away from the group and sidestep to dodge it."
L["MT_trash_spellbreaker_note"]       = "After defeating Seranel Sunlash, climb the platform behind her arena and channel on the |cffAA88FFCynosure of Twilight|r to summon a wave of void mobs to fight through."
-- Trash descriptions — Voidling
L["MT_trash_voidling_desc1"]          = "• The tank should know that these mobs deal additional shadow damage in melee through the passive %s."
-- Trash descriptions — Hollowsoul Shredder
L["MT_trash_shredder_desc1"]          = "• %s — Random player target; stay close to the group to cleave these mobs easily."
-- Trash descriptions — Dreaded Voidwalker
L["MT_trash_voidwalker_desc1"]        = "• %s — Random player target; use available interrupts."
-- Trash descriptions — Shadowrift Voidcaller
L["MT_trash_voidcaller_desc1"]        = "• The tank should pick up mobs created by %s."
L["MT_trash_voidcaller_desc2"]        = "• %s — Deals heavy group damage; be ready with healing cooldowns or defensives, and use Line of Sight if needed to avoid damage entirely."
-- Trash descriptions — Unstable Voidling
L["MT_trash_unstable_desc1"]          = "• Stagger the kills to avoid being overwhelmed by their death cast %s."
-- Trash descriptions — Void Infuser
L["MT_trash_void_infuser_desc1"]      = "• |cffFF4444Interrupt|r every cast of %s without exception."
L["MT_trash_void_infuser_desc2"]      = "• %s — Debuff on a random player; healers should dispel targets quickly or use defensives and cooldowns if too many targets are debuffed simultaneously."
-- Trash descriptions — Devouring Tyrant
L["MT_trash_tyrant_desc1"]            = "• %s — Targets the tank; be ready with a defensive and any self-healing available to help the healer overcome the massive healing absorption it applies."
L["MT_trash_tyrant_desc2"]            = "• %s — Random player target; avoid cleaving allies and use any self-healing available to help the healer overcome the healing absorption it applies."
-- Boss 1: Arcanotron Custos
L["MT_boss1_desc1"]                   = "• %s — AoE hit + knockback that drops a pool under the boss for 2 minutes. Try to place them on the room's edges or overlapping with existing pools to preserve space."
L["MT_boss1_desc2"]                   = "• %s — Targets 2 random players; use a magic dispel or freedom effect to remove it; otherwise use a defensive if it overlaps with %s."
L["MT_boss1_desc3"]                   = "• The tank must have a defensive ready for the arcane hit and knockback from %s; use the room's geometry to limit the knockback if needed."
L["MT_boss1_desc4"]                   = "• At 0 energy, the boss casts %s: use damage cooldowns here and spread slightly to soak incoming %s. Note: orbs drop additional pools and apply the DoT %s — use a defensive if needed."
-- Boss 2: Seranel Sunlash
L["MT_boss2_desc1"]                   = "• The boss drops a %s under itself; try to place it near the center of the arena to make managing the %s debuff easier, while staying spread to avoid cleaving each other."
L["MT_boss2_desc2"]                   = "• When %s is purged/expires, the 2 targets must leave space between them to avoid comboing the group with multiple %s hits. The 2nd player to clear their debuff may need a defensive."
L["MT_boss2_desc3"]                   = "• If a purge is available, use it to remove the buff %s; otherwise the tank must use a defensive while it is active."
L["MT_boss2_desc4"]                   = "• During %s's cast, step into %s just before the cast ends to avoid the 8-second pacify it applies."
-- Boss 3: Gemellus
L["MT_boss3_desc1"]                   = "• %s — Cast at the start of the fight and at 50%% health. Cleave clones as much as possible since they share HP. Each clone focuses its abilities on a different player — below 50%%, all players (including the tank) are targeted."
L["MT_boss3_desc2"]                   = "• %s — Drops a pool under the target; place them outside movement paths."
L["MT_boss3_desc3"]                   = "• %s — Debuff on a player: run toward the clone indicated by the arrow under their feet and touch it to remove the debuff and the boss's shield."
L["MT_boss3_desc4"]                   = "• %s — If targeted, move away from the pull-in and simultaneously avoid circles that appear around all clones."
-- Boss 4: Degentrius
L["MT_boss4_desc1"]                   = "• Avoid the %s beam that cuts the arena in two, and split the group on both sides of the beam to soak %s."
L["MT_boss4_desc2"]                   = "• The tank must avoid cleaving allies with %s, then back away and get dispelled by the healer to remove the magic DoT and place the pool away from melee. The boss does not melee: it uses %s on the tank regardless of position."
L["MT_boss4_desc3"]                   = "• %s — Debuffs multiple players with different durations; be ready with a defensive if the duration is long, and aim orbs so other players can see them."
L["MT_boss4_desc4"]                   = "|cffFF4444!! Critical:|r Degentrius periodically casts %s, which bounces around the room before forming a %s. The closest player must rush onto the zone to soak the damage and prevent the rest of the group from taking it."

-- Maisara Caverns (MC) — uiMapId 2501
L["MC_name"]              = "Maisara Caverns"
-- Intro
L["MC_intro_desc1"]       = "Maisara Caverns — Midnight Season 1, new dungeon."
L["MC_intro_desc2"]       = "3 bosses: Muro'jin &amp; Nekraxx -> Vordaza -> Rak'tul (Vessel of Souls)."
-- Notable Trash mob names
L["MC_trash_berserker_name"]   = "Frenzied Berserker & Keen Headhunter"
L["MC_trash_juggernaut_name"]  = "Hulking Juggernaut"
L["MC_trash_hexxer_name"]      = "Ritual Hexxer"
L["MC_trash_guardian_name"]    = "Hex Guardian"
L["MC_trash_skirmisher_name"]  = "Grim Skirmisher"
L["MC_trash_soulrender_name"]  = "Hollow Soulrender"
L["MC_trash_defender_name"]    = "Bound Defender"
L["MC_trash_shade_name"]       = "Tormented Shade"
-- Trash descriptions
L["MC_trash_berserker_desc1"]  = "%s: frenzy buff — Soothe or equivalent. %s: passive healing — use healing reduction effects."
L["MC_trash_berserker_desc2"]  = "%s (Keen Headhunter): interrupt or use a freedom effect on the target. %s: stack in melee to avoid damage on ranged targets."
L["MC_trash_juggernaut_desc1"] = "%s: interrupt. If the cast goes through, everyone must stop casting immediately. %s: bleed on the tank — defensive or purge."
L["MC_trash_hexxer_desc1"]     = "%s: interrupt every cast without exception. If the hex goes through, dispel is priority. %s: use remaining interrupts."
L["MC_trash_guardian_desc1"]   = "%s: permanent AoE pulses — offensive and defensive cooldowns on this mob. %s: magic debuff on two players with circles — dispel and dodge. %s: attack line toward a random player — position to avoid hitting allies."
L["MC_trash_skirmisher_desc1"] = "%s: magic shield — alternate purges to break it efficiently."
L["MC_trash_soulrender_desc1"] = "%s: channel that detonates nearby Lost Souls — must interrupt. %s: interrupt. %s: freeze on a random player — dispel or immunity."
L["MC_trash_defender_desc1"]   = "%s: shadow AoE damage on each strike. %s: rotating mechanics around the mob — move to avoid. %s: the tank must position the mob to avoid reflecting damage onto the group."
L["MC_trash_shade_desc1"]      = "%s: 2.5s cast applying a stacking Shadow DoT (initial hit + 8s tick) — interrupt when possible. Healers should not magic dispel the first stack; wait until a player accumulates multiple stacks, then dispel to save GCDs."
-- Boss 1: Muro'jin & Nekraxx
L["MC_boss1_name"]             = "Muro'jin & Nekraxx"
L["MC_boss1_desc1"]            = "Priority: kill Nekraxx first. If Muro'jin dies first, she gains massive buffs via %s. If Nekraxx dies, Muro'jin will attempt to resurrect her via %s — interrupt without fail."
L["MC_boss1_desc2"]            = "%s: Nekraxx dashes toward a target in flight. %s on the ground stop her if she flies through them — position them in her path."
L["MC_boss1_desc3"]            = "%s: tank buster with bleed — use a defensive or purge the bleed."
L["MC_boss1_desc4"]            = "%s: group disease — dispel quickly to reduce incoming damage."
L["MC_boss1_desc5"]            = "%s: ground circles to dodge."
L["MC_boss1_desc6"]            = "%s: frontal channel with magic slow — stand still; slowed allies must exit the cone."
-- Boss 2: Vordaza
L["MC_boss2_name"]             = "Vordaza"
L["MC_boss2_desc1"]            = "%s: spectres are summoned and move toward players. They explode on contact — dodge their path."
L["MC_boss2_desc2"]            = "%s: channel targeting the tank — use a strong defensive."
L["MC_boss2_desc3"]            = "%s: frontal sweep — reposition behind the boss."
L["MC_boss2_desc4"]            = "%s: channel protected by a shield — break the shield then interrupt the cast."
-- Boss 3: Rak'tul, Vessel of Souls
L["MC_boss3_name"]             = "Rak'tul, Vessel of Souls"
L["MC_boss3_desc1"]            = "%s: passive aura creating circles around the boss — keep moving."
L["MC_boss3_desc2"]            = "%s: attack combo dropping pools on the ground — use defensives and mobility."
L["MC_boss3_desc3"]            = "%s: targets three players simultaneously and summons a %s per target — destroy the totems quickly to break the link."
L["MC_boss3_desc4"]            = "%s: sends players to the bridge for a gauntlet phase. Interrupt and control Malignant Souls to gain %s and reduce %s — damage escalates progressively if you delay."
L["MC_boss3_desc5"]            = "%s: on the bridge, Lost Souls root players — use freedom effects or break the bonds quickly."

-- Nexus-Point Xenas (NPX) — uiMapId 2556
L["NPX_name"]             = "Nexus-Point Xenas"
-- Intro
L["NPX_intro_desc1"]      = "Nexus-Point Xenas — Midnight Season 1, new dungeon."
L["NPX_intro_desc2"]      = "3 bosses: Chief Corewright Kasreth -> Corewarden Nysarra -> Lothraxion."
-- Notable Trash mob names
L["NPX_trash_arcanist_name"]   = "Corewright Arcanist"
L["NPX_trash_engineer_name"]   = "Flux Engineer"
L["NPX_trash_seer_name"]       = "Circuit Seer"
L["NPX_trash_scrounger_name"]  = "Hollowsoul Scrounger"
L["NPX_trash_nullifier_name"]  = "Grand Nullifier"
L["NPX_trash_dreadflail_name"] = "Dreadflail"
L["NPX_trash_lightwrought_name"] = "Lightwrought"
L["NPX_trash_voidcaller_name"] = "Cursed Voidcaller"
-- Trash descriptions
L["NPX_trash_arcanist_desc1"]  = "%s: channel to interrupt. %s: magic debuff — dispel quickly."
L["NPX_trash_engineer_desc1"]  = "%s: move away before the cast to avoid hitting allies. On death, leaves an active Mana Battery on the ground — avoid activating it accidentally."
L["NPX_trash_seer_desc1"]      = "%s: channel with significant damage — defensive cooldowns. %s: activates nearby Mana Batteries — kill this mob away from batteries or destroy them first."
L["NPX_trash_scrounger_desc1"] = "%s: healing channel triggered at 45%% health — interruptible and CC-able."
L["NPX_trash_nullifier_desc1"] = "%s: interrupt. %s: fear zone to dodge. Transforms into a Smudge on death."
L["NPX_trash_dreadflail_desc1"] = "%s: tank buster — defensive. %s: AoE zone — kite the mob or use group cooldowns."
L["NPX_trash_lightwrought_desc1"] = "%s: interruptible spell targeting a random player. %s: magic debuff on 2 players — dispel."
L["NPX_trash_voidcaller_desc1"] = "%s: channel applying lethal damage — dispel curses immediately."
-- Boss 1: Chief Corewright Kasreth
L["NPX_boss1_name"]            = "Chief Corewright Kasreth"
L["NPX_boss1_desc1"]           = "%s: energy beams cross the room. Players affected by %s can stand at beam intersections to deactivate them."
L["NPX_boss1_desc2"]           = "%s: creates pools — drag them toward the room's edges to keep the center clear."
L["NPX_boss1_desc3"]           = "%s: applies a healing absorption and knockback — anticipate the movement."
L["NPX_boss1_desc4"]           = "%s: instant arcane damage replacing the boss's normal strikes."
-- Boss 2: Corewarden Nysarra
L["NPX_boss2_name"]            = "Corewarden Nysarra"
L["NPX_boss2_desc1"]           = "%s: targets two players — use a defensive and position to avoid hitting allies."
L["NPX_boss2_desc2"]           = "%s: summons a Dreadflail and 2 Grand Nullifiers. Kill adds before the channel ends — if the channel ends with adds alive, %s consumes them and empowers the boss."
L["NPX_boss2_desc3"]           = "%s: channel targeting the tank — use a strong defensive."
L["NPX_boss2_desc4"]           = "%s: an image creates a frontal with 300%% damage amplification — never stand in the cone."
-- Boss 3: Lothraxion
L["NPX_boss3_name"]            = "Lothraxion"
L["NPX_boss3_desc1"]           = "%s: leaves persistent pools on the ground — drop them on the room's edges."
L["NPX_boss3_desc2"]           = "%s: targets 3 players — spread away from allies to avoid splash damage."
L["NPX_boss3_desc3"]           = "%s: dash hitting players in its path — move laterally."
L["NPX_boss3_desc4"]           = "%s: the boss hides among images. %s: images strike anyone within 5 yards. Identify and interrupt the real target to trigger %s."

-- Windrunner Spire (WRS) — uiMapId 2492+
L["WRS_name"]             = "Windrunner Spire"
-- Intro
L["WRS_intro_desc1"]      = "Windrunner Spire — Midnight Season 1, new dungeon."
L["WRS_intro_desc2"]      = "4 bosses: Emberdawn -> Derelict Duo (Kalis &amp; Latch) -> Commander Kroluk -> The Restless Heart."
-- Notable Trash mob names
L["WRS_trash_magus_name"]       = "Spellguard Magus"
L["WRS_trash_steward_name"]     = "Restless Steward"
L["WRS_trash_woebringer_name"]  = "Devoted Woebringer"
L["WRS_trash_behemoth_name"]    = "Flesh Behemoth"
L["WRS_trash_mystic_name"]      = "Phantasmal Mystic"
-- Trash descriptions
L["WRS_trash_magus_desc1"]      = "%s: group damage — defensive cooldowns. %s: at 50%% health, creates a 99%% damage reduction zone — never remain in this zone; kill the mob quickly."
L["WRS_trash_steward_desc1"]    = "%s: interrupt. %s: magic debuff — dispel."
L["WRS_trash_woebringer_desc1"] = "%s: interrupt. %s: cast protected by a shield — break the shield or interrupt."
L["WRS_trash_behemoth_desc1"]   = "%s: spread to avoid splash damage. %s: tank buster — defensive."
L["WRS_trash_mystic_desc1"]     = "%s: interrupt. %s: enrage at 50%% health — Soothe immediately."
-- Boss 1: Emberdawn
L["WRS_boss1_name"]             = "Emberdawn"
L["WRS_boss1_desc1"]            = "%s: debuff on 2 players — move toward the arena's edges to drop the pool before it explodes."
L["WRS_boss1_desc2"]            = "%s: intermission with massive damage and fire frontals — group cooldowns and move out of cones. %s: tank buster with DoT — defensive on every cast."
-- Boss 2: Derelict Duo (Kalis & Latch)
L["WRS_boss2_name"]             = "Derelict Duo (Kalis & Latch)"
L["WRS_boss2_desc1"]            = "%s: Kalis cast — permanent interrupt rotation. %s: curse — dispel immediately."
L["WRS_boss2_desc2"]            = "%s + %s: both bosses combine their effects simultaneously — defensives and mobility. %s: spread to avoid splash damage."
L["WRS_boss2_desc3"]            = "%s: channel targeting the tank — strong defensive."
-- Boss 3: Commander Kroluk
L["WRS_boss3_name"]             = "Commander Kroluk"
L["WRS_boss3_desc1"]            = "%s: bursts of casts, always targeting the farthest player — stay grouped near the tank except the designated target who moves away. %s: proximity mechanic — move away from the boss."
L["WRS_boss3_desc2"]            = "%s: summons adds at 66%% and 33%% — group cooldowns. %s: fixates on a player — kite in circles. %s: tank channel — defensive."
-- Boss 4: The Restless Heart
L["WRS_boss4_name"]             = "The Restless Heart"
L["WRS_boss4_desc1"]            = "%s: stacking debuff — stand on ground arrows to clear it before %s. %s: summons %s — dodge the moving arrows."
L["WRS_boss4_desc2"]            = "%s: spread — also clears ground pools; use wisely. %s: frontal toward a random player — the target stands still to help others dodge. %s: tank buster with knockback — defensive."

-- Murder Row (MR)
L["MR_name"]              = "Murder Row"

-- Voidscar Arena (VA)
L["VA_name"]              = "Voidscar Arena"
