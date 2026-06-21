local myname = ...

local L = LibStub("AceLocale-3.0"):NewLocale(myname, "ruRU", false)
if not L then return end

L["Ready"] = "Готовы?"
L["DungeonCountdown"] = "MythicKeystone: Активация ключа через 5 секунд, пристегнитесь и приготовьтесь."
L["DungeonStarted"] = "MythicKeystone: Ключ вставлен, желаем удачного прохождения, старайтесь изо всех сил и остерегайтесь огня!"
L["DungeonCountdownStop"] = "MythicKeystone: Активация ключа остановлена."

L["AddonName"] = "Mythic Keystones"
L["Alts"] = "Альты"
L["Guild"] = "Гильдия"
L["Group"] = "Группа"
L["Refresh"] = "Кликните для обновления."
L["ReadyCheck"] = "Проверка готовности"
L["Countdown"] = "Обратный отсчёт"
L["Countdown_cancel"] = "Отмена"

-- Кнопки телепортации
L["TELEPORT_hide"] = "Скрыть телепорты"
L["TELEPORT_show"] = "Показать телепорты"

-- Панель настроек
L["OPT_showAlts"]       = "Показывать панель альтов"
L["OPT_showAlts_tip"]   = "Показывает ключи Ваших альтов в окне поиска группы."
L["OPT_showGroup"]      = "Показывать панель группы"
L["OPT_showGroup_tip"]  = "Показывает ключи участников Вашей группы."
L["OPT_showGuild"]      = "Показывать панель гильдии"
L["OPT_showGuild_tip"]  = "Показывает ключи Вашей гильдии."
L["OPT_teleports"]      = "Показывать кнопки телепортации"
L["OPT_teleports_tip"]  = "Показывает кнопки телепортации подземелий в интерфейсе М+."
L["OPT_autoSlot"]       = "Автоматически вставлять ключ"
L["OPT_autoSlot_tip"]   = "Автоматически вставляет Ваш ключ при открытии интерфейса М+."
L["OPT_readyCheck"]     = "Показывать кнопку проверки готовности"
L["OPT_readyCheck_tip"] = "Добавляет кнопку проверки готовности в окно запуска М+."
L["OPT_countdown"]      = "Показывать кнопку обратного отсчёта"
L["OPT_countdown_tip"]  = "Добавляет кнопку обратного отсчёта в окно запуска М+."

-- About popup
L["ABOUT_btn_tooltip"] = "Об этом аддоне"
L["ABOUT_title"] = "О MythicKeystone"
L["ABOUT_author"] = "Автор: Willou"
L["ABOUT_description"] = "Ваши ключи, ключи Ваших альтов, ключи Вашей группы и ключи Вашей гильдии - всё во фрейме поиска группы (LFG), в реальном времени."
L["ABOUT_other_header"] = "Также загляните в Mythic Dungeon Notes"
L["ABOUT_other_pitch"] = "Все стратегии для подземелий и заметки к боссам - в игре, в один клик."
L["ABOUT_other_feature_1"] = "• Все M+ подземелья"
L["ABOUT_other_feature_2"] = "• Стратегии боссов, советы по трешу, прерывания"
L["ABOUT_other_feature_3"] = "• Автоопределение зоны открывает нужное руководство"
L["ABOUT_other_feature_4"] = "• Встроенные кнопки телепортации"
L["ABOUT_other_companion"] = "Всё в удобном формате из двух колонок, с картами и иконками заклинаний."
L["ABOUT_links_header"] = "Ссылки"
L["ABOUT_link_curseforge"] = "CurseForge"
L["ABOUT_link_wago"] = "Wago"
L["ABOUT_link_github"] = "GitHub"
L["ABOUT_url_popup_text"] = "Скопируйте этот URL с помощью Ctrl+C:"
