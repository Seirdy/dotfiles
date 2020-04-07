// disable auto connections for updates, since I handle updates outside the browser
user_pref("app.update.url", "");
user_pref("app.update.url.manual", "");
user_pref("app.update.enabled", false);
user_pref("app.update.auto", false);
user_pref("app.update.service.enabled", false);
user_pref("app.update.BITS.enabled", false);
user_pref("lightweightThemes.update.enabled", false);
user_pref("browser.showQuitWarning", true);
user_pref("apz.gtk.kinetic_scroll.enabled", false);
// disable WebRTC
user_pref("media.navigator.enabled", false);
user_pref("media.navigator.video.enabled", false);
user_pref("media.peerconnection.enabled", false);
user_pref("media.peerconnection.ice.default_address_only", true);
user_pref("media.peerconnection.ice.no_host", true);
user_pref("media.peerconnection.use_document_iceservers", false);
user_pref("media.peerconnection.turn.disable", true);
user_pref("media.peerconnection.video.enabled", false);
user_pref("media.peerconnection.identity.enabled", false);
user_pref("media.peerconnection.identity.timeout", 1);
// kill all plugins
user_pref("plugin.default.state", 0);
user_pref("plugin.scan.plid.all", false);
user_pref("plugin.defaultXpi.state", 0);
// kill the gmp; use mpv for that stuff instead
// Also kill drm
user_pref("media.gmp-provider.enabled", false);
user_pref("media.gmp-gmpopenh264.enabled", false);
user_pref("media.gmp-gmpopenh264.autoupdate", false);
user_pref("media.gmp-manager.updateEnabled", false);
user_pref("media.gmp-manager.url", "data:text/plain,");
user_pref("media.gmp-manager.url.override", "data:text/plain,");
user_pref("media.gmp.trial-create.enabled", false);
user_pref("media.getusermedia.screensharing.enabled", false);
user_pref("media.getusermedia.audiocapture.enabled", false);
user_pref("media.gmp-widevinecdm.visible", false);
user_pref("media.gmp-widevinecdm.enabled", false);
user_pref("media.eme.enabled", false);
user_pref("media.eme.apiVisible", false);
user_pref("browser.eme.ui.enabled", false);
user_pref("media.gmp-eme-adobe.enabled", false);
user_pref("dom.battery.enabled", false);
user_pref("geo.enabled", false);
user_pref("geo.wifi.uri", "");
user_pref("browser.search.geoip.url", "");
user_pref("browser.search.geoSpecificDefaults.url", "");
user_pref("browser.selfsupport.url", "");
user_pref("browser.chrome.errorReporter.infoURL", "");
user_pref("browser.aboutHomeSnippets.updateUrL", "");
user_pref("browser.startup.homepage_override.buildID", "");
user_pref("startup.homepage_welcome_url", "");
user_pref("startup.homepage_welcome_url.additional", "");
user_pref("startup.homepage_override_url", "");
user_pref("browser.startup.homepage_override.mstone", "ignore");
user_pref("browser.search.countryCode", "US"); // (hidden pref)
user_pref("browser.search.region", "US"); // (hidden pref)
user_pref("general.useragent.locale", "en-US");
user_pref("browser.search.geoSpecificDefaults", false);
user_pref("intl.accept_languages", "en-US, en");
user_pref("javascript.use_us_english_locale", true);
user_pref("browser.newtab.preload", false);
user_pref("browser.newtabpage.enabled", false);
user_pref("browser.newtabpage.enhanced", false);
user_pref("browser.newtabpage.introShown", true);
user_pref("browser.newtabpage.directory.source", "");
user_pref("social.whitelist", "");
user_pref("social.toast-notifications.enabled", false);
user_pref("social.shareDirectory", "");
user_pref("social.remote-install.enabled", false);
user_pref("social.directories", "");
user_pref("social.share.activationPanelEnabled", false);
user_pref("social.enabled", false); // (hidden pref)
user_pref("browser.onboarding.enabled", false);
user_pref("extensions.getAddons.showPane", false);
user_pref("extensions.getAddons.cache.enabled", false);
user_pref("extensions.getAddons.discovery.api_url", "");
user_pref("lightweightThemes.update.enabled", false);
user_pref("extensions.webservice.discoverURL", "");
user_pref("extensions.getAddons.get.url", "");
user_pref("extensions.getAddons.discovery.api_url", "");
user_pref("extensions.getAddons.compatOverides.url", "");
user_pref("extensions.getAddons.langpacks.url", "");
user_pref("extensions.getAddons.link.url", "");
user_pref("extensions.getAddons.search.browseURL", "");
user_pref("extensions.htmlaboutaddons.discover.enabled", false);
user_pref("extensions.htmlaboutaddons.recommendations.enabled", false);
user_pref("extensions.recommendations.themeRecommendationUrl", "");
// system addons
user_pref("extensions.systemAddon.update.enabled", false);
user_pref("extensions.systemAddon.update.url", "");
user_pref("extensions.formautofill.addresses.enabled", false);
user_pref("extensions.formautofill.creditCards.enabled", false); // (FF56+)
user_pref("extensions.formautofill.experimental", false);
user_pref("extensions.formautofill.heuristics.enabled", false);
user_pref("browser.formfill.enable", false);
user_pref("browser.formfill.expire_days", 0);
user_pref("extensions.formautofill.available", "off");
user_pref("extensions.formautofill.creditCards.available", false);
// I use a Real Password Manager, so Firefox's password manager is useless.
user_pref("signon.rememberSignons", false);
user_pref("signon.autofillForms", false);
user_pref("signon.storeWhenAutocompleteOff", false);
/*disale captive portal phoning home to detectportal.firefox.com*/
user_pref("network.captive-portal-service.enabled", false);
user_pref("captivedetect.canonicalURL", "");
user_pref("network.protocol-handler.external.ms-windows-store", false);
/* 0809: disable location bar suggesting "preloaded" top websites (FF54+)
 * [1] https://bugzilla.mozilla.org/show_bug.cgi?id=1211726 ***/
user_pref("browser.urlbar.usepreloadedtopurls.enabled", false);
/* 0810: disable location bar making speculative connections (FF56+)
 * [1] https://bugzilla.mozilla.org/show_bug.cgi?id=1348275 ***/
user_pref("browser.urlbar.speculativeConnect.enabled", false);
/* 0850a: disable location bar autocomplete [controlled by 0850b] ***/
   // user_pref("browser.urlbar.autocomplete.enabled", false);
/* 0850b: disable location bar suggestion types [controls 0850a]
 * [SETTING] Options>Privacy>Location Bar>When using the location bar, suggest
 * [NOTE] If any of these are true, 0850a will be FORCED to true
 * and if all three are false, 0850a will be FORCED to false
 * [WARNING] If all three are false, search engine keywords are disabled ***/
user_pref("browser.urlbar.suggest.history", false);
user_pref("browser.urlbar.oneOffSearches", false);
user_pref("browser.newtabpage.activity-stream.feeds.telemetry", false);
user_pref("browser.newtabpage.activity-stream.telemetry", false);
user_pref("browser.library.activity-stream.enabled", false);
user_pref("browser.newtabpage.activity-stream.default.sites", "");
user_pref("browser.newtabpage.activity-stream.asrouter.providers.whats-new-panel", "");
user_pref("browser.newtabpage.activity-stream.asrouter.providers.snippets", "");
user_pref("browser.newtabpage.activity-stream.asrouter.providers.onboarding", "");
user_pref("browser.newtabpage.activity-stream.asrouter.providers.cfr-fxa", "");
user_pref("browser.newtabpage.activity-stream.asrouter.providers.cfr", "");
user_pref("browser.newtabpage.activity-stream.discoverystream.config", "");
user_pref("browser.newtabpage.activity-stream.feeds.section.topstories.options", "");
user_pref("browser.newtabpage.activity-stream.telemetry.structuredIngestion.endpoint", "");
user_pref("browser.pageActions.persistedActions", "");
user_pref("toolkit.telemetry.unified", false);
user_pref("toolkit.telemetry.enabled", false);
user_pref("toolkit.telemetry.server", "");
user_pref("toolkit.telemetry.archive.enabled", false);
user_pref("toolkit.telemetry.cachedClientID", "");
user_pref("toolkit.telemetry.newProfilePing.enabled", false); // (FF55+)
user_pref("toolkit.telemetry.bhrPing.enabled", false);
user_pref("toolkit.telemetry.firstShutdownPing.enabled", false);
user_pref("toolkit.telemetry.shutdownPingSender.enabled", false); // (FF55+)
user_pref("toolkit.telemetry.updatePing.enabled", false); // (FF56+)
user_pref("toolkit.telemetry.reportingpolicy.firstRun", false);
user_pref("toolkit.telemetry.hybridContent.enabled", false);
// disable ping-centre
user_pref("browser.ping-centre.telemetry", false);
user_pref("browser.ping-centre.production.endpoint", "");
user_pref("browser.ping-centre.staging.endpoint", "");
/* 0333a: disable health report ***/
user_pref("datareporting.healthreport.uploadEnabled", false);
/* 0333b: disable about:healthreport page (which connects to Mozilla for locale/css+js+json)
 * If you have disabled health reports, then this about page is useless - disable it
 * If you want to see what health data is present, then this must be set at default ***/
user_pref("datareporting.healthreport.about.reportUrl", "data:text/plain,");
/* 0334: disable new data submission, master kill switch (FF41+)
 * If disabled, no policy is shown or upload takes place, ever
 * [1] https://bugzilla.mozilla.org/show_bug.cgi?id=1195552 ***/
user_pref("datareporting.policy.dataSubmissionEnabled", false);
/* 0350: disable crash reports ***/
user_pref("breakpad.reportURL", "");
user_pref("datareporting.healthreport.service.enabled", false);
user_pref("datareporting.healthreport.about.reportUrlUnified", "");
/* 0351: disable sending of crash reports (FF44+) ***/
user_pref("browser.tabs.crashReporting.sendReport", false);
user_pref("browser.crashReports.unsubmittedCheck.enabled", false); // (FF51+)
user_pref("browser.crashReports.unsubmittedCheck.autoSubmit", false); // (FF51+)
// SSL error reporting
user_pref("security.ssl.errorReporting.enabled", false);
user_pref("security.ssl.errorReporting.url", "");
user_pref("extensions.webcompat-reporter.enabled", false);
/* 0360: disable new tab tile ads & preload & marketing junk ***/
user_pref("browser.newtab.preload", false);
user_pref("browser.newtabpage.directory.source", "data:text/plain,");
user_pref("browser.newtabpage.enabled", false);
user_pref("browser.newtabpage.enhanced", false);
user_pref("experiments.enabled", false);
user_pref("experiments.manifest.uri", "");
user_pref("experiments.supported", false);
user_pref("experiments.activeExperiment", false);
/* 0502: disable Mozilla permission to silently opt you into tests ***/
user_pref("network.allow-experiments", false);
user_pref("dom.flyweb.enabled", false);
/* 0512: disable Shield (FF53+)
 * Shield is an telemetry system (including Heartbeat) that can also push and test "recipes"
 * [1] https://wiki.mozilla.org/Firefox/Shield
 * [2] https://github.com/mozilla/normandy ***/
user_pref("extensions.shield-recipe-client.enabled", false);
user_pref("extensions.shield-recipe-client.api_url", "");
user_pref("app.shield.optoutstudies.enabled", false);
user_pref("app.normandy.enabled", false);
user_pref("app.normandy.api_url", "");
user_pref("app.normandy.user_id", "");
user_pref("app.normandy.run_interval_seconds", 999999);
/* 0513: disable Follow On Search (FF53+)
 * Just DELETE the XPI file in your system extensions directory
 * [1] https://blog.mozilla.org/data/2017/06/05/measuring-search-in-firefox/ ***/
/* 0514: disable Activity Stream (FF54+)
 * Activity Stream replaces "New Tab" with one based on metadata and browsing behavior,
 * and includes telemetry as well as web content such as snippets and "spotlight"
 * [1] https://wiki.mozilla.org/Firefox/Activity_Stream
 * [2] https://www.ghacks.net/2016/02/15/firefox-mockups-show-activity-stream-new-tab-page-and-share-updates/ ***/
/* 0808: disable location bar LIVE search suggestions (requires 0807 = true) - PRIVACY
 * Also disable the location bar prompt to enable/disable or learn more about it.
 * [SETTING] Options>Search>Show search suggestions in address bar results ***/
user_pref("browser.urlbar.suggest.searches", false);
user_pref("browser.urlbar.userMadeSearchSuggestionsChoice", true);
user_pref("browser.snippets.updateUrl", "");
user_pref("browser.snippets.statsUrl", "");
user_pref("browser.snippets.geoUrl", "");

// misc auto-downloading
user_pref("browser.dictionaries.download.url", "");
user_pref("browser.uitour.url", "");

/*disable builtin extensions*/
user_pref("extensions.pocket.enabled", false);
user_pref("extensions.pocket.site", "");
user_pref("extensions.pocket.oAuthConsumerKey", "");
user_pref("extensions.pocket.api", "");
user_pref("extensions.screenshots.disabled", true);
user_pref("extensions.screenshots.upload-disabled", true);
user_pref("beacon.enabled", false);
/*allow addons on AMO*/
user_pref("privacy.resistFingerprinting.block_mozAddonManager", true);
user_pref("extensions.webextensions.restrictedDomains", "");
/*Disable page thumbnails capturing*/
user_pref("browser.pagethumbnails.capturing_disabled", true);
/*don't prerender activity-stream*/
user_pref("browser.newtabpage.activity-stream.prerender", false);
/*Clear the NTP*/
user_pref("browser.newtabpage.activity-stream.asrouter.providers.snippets", "");
user_pref("browser.newtabpage.activity-stream.discoverystream.endpointSpocsClear", "");
user_pref("browser.newtabpage.activity-stream.discoverystream.endpoints", "");
user_pref("browser.newtabpage.activity-stream.feeds.aboutpreferences", false);
user_pref("browser.newtabpage.activity-stream.feeds.discoverystreamfeed", false);
user_pref("browser.newtabpage.activity-stream.feeds.section.highlights", false);
user_pref("browser.newtabpage.activity-stream.feeds.section.topstories", false);
user_pref("browser.newtabpage.activity-stream.feeds.snippets", false);
user_pref("browser.newtabpage.activity-stream.feeds.topsites", false);
user_pref("browser.newtabpage.activity-stream.section.highlights.includeBookmarks", false);
user_pref("browser.newtabpage.activity-stream.section.highlights.includeDownloads", false);
user_pref("browser.newtabpage.activity-stream.section.highlights.includePocket", false);
user_pref("browser.newtabpage.activity-stream.section.highlights.includeVisited", false);
user_pref("browser.newtabpage.activity-stream.showSearch", false);
user_pref("browser.newtabpage.activity-stream.showSponsored", false);
user_pref("browser.newtabpage.activity-stream.disableSnippets", true);
user_pref("browser.newtabpage.activity-stream.telemetry.ping.endpoint", "");

// misc privacy
user_pref("privacy.firstparty.isolate", true);
user_pref("browser.sessionrestore.privacy_level", 2);

user_pref("browser.urlbar.speculativeConnect.enabled", false);
user_pref("browser.urlbar.trimURLs", false);

/*Deny most permissions*/
user_pref("permissions.default.camera", 2);
user_pref("permissions.default.desktop-notification", 2);
user_pref("permissions.default.geo", 2);
user_pref("permissions.default.microphone", 2);

/*Extension blocklist*/
user_pref("extensions.blocklist.enabled", false);
user_pref("extensions.blocklist.url", "");
user_pref("extensions.blocklist.itemURL", "");
user_pref("extensions.blocklist.detailsURL", "");
user_pref("xpinstall.signatures.required", false);
/*Safebrowsing*/
user_pref("browser.safebrowsing.enabled ", false);
user_pref("browser.safebrowsing.downloads.remote.block_potentially_unwanted", false);
user_pref("browser.safebrowsing.downloads.remote.block_uncommon", false);
user_pref("browser.safebrowsing.downloads.remote.block_dangerous", false);
user_pref("browser.safebrowsing.downloads.remote.block_dangerous_host", false);
user_pref("browser.safebrowsing.phishing.enabled ", false);
user_pref("browser.safebrowsing.malware.enabled ", false);
user_pref("browser.safebrowsing.downloads.enabled ", false);
user_pref("browser.safebrowsing.provider.google4.dataSharing.enabled", "");
user_pref("browser.safebrowsing.provider.mozilla.gethashURL", "");
user_pref("browser.safebrowsing.provider.mozilla.lists", "");
user_pref("browser.safebrowsing.provider.mozilla.updateURL", "");
user_pref("browser.safebrowsing.provider.google4.updateURL", "");
user_pref("browser.safebrowsing.provider.google4.reportURL", "");
user_pref("browser.safebrowsing.provider.google4.reportPhishMistakeURL", "");
user_pref("browser.safebrowsing.provider.google4.reportMalwareMistakeURL", "");
user_pref("browser.safebrowsing.provider.google4.lists", "");
user_pref("browser.safebrowsing.provider.google4.gethashURL", "");
user_pref("browser.safebrowsing.provider.google4.dataSharingURL", "");
user_pref("browser.safebrowsing.provider.google4.dataSharing.enabled ", false);
user_pref("browser.safebrowsing.provider.google4.advisoryURL", "");
user_pref("browser.safebrowsing.provider.google4.advisoryName", "");
user_pref("browser.safebrowsing.provider.google.updateURL", "");
user_pref("browser.safebrowsing.provider.google.reportURL", "");
user_pref("browser.safebrowsing.provider.google.reportPhishMistakeURL", "");
user_pref("browser.safebrowsing.provider.google.reportMalwareMistakeURL", "");
user_pref("browser.safebrowsing.provider.google.pver", "");
user_pref("browser.safebrowsing.provider.google.lists", "");
user_pref("browser.safebrowsing.provider.google.gethashURL", "");
user_pref("browser.safebrowsing.provider.google.advisoryURL", "");
user_pref("browser.safebrowsing.downloads.remote.enabled", false);
user_pref("browser.safebrowsing.downloads.remote.url", "");
// Disable firefox accounts; just use a dotfile manaager and rsync the extensions.
user_pref("identity.fxaccounts.pairing.enabled", false);
user_pref("identity.fxaccounts.pairing.uri", "");
user_pref("identity.fxaccounts.enabled", false);
user_pref("identity.sync.tokenserver.uri", "");
user_pref("webextensions.storage.sync.serverURL", "");
// devtools telemetry
user_pref("devtools.onboarding.telemetry.logged", false);
user_pref("devtools.remote.adb.extensionURL", "");
user_pref("devtools.webide.autoinstallADBExtension", false);
user_pref("devtools.webide.autoinstallADBHelper", false);
// firefox monitor
user_pref("browser.contentblocking.report.monitor.enabled", false);
user_pref("browser.contentblocking.report.monitor.url", "");
user_pref("extensions.fxmonitor.firstAlertShown", "");
user_pref("browser.contentblocking.report.monitor.enabled", false);
// DNS should obey my system settings, thank you very much.
user_pref("network.trr.mode", 5);
user_pref("network.trr.resolvers", "");
user_pref("network.trr.bootstrapAddress", "");
user_pref("network.trr.uri", "");
// I use mpv via a native messenger to open videos outside the browser in a floating
// window, so picture-in-picture is unnecessary.
user_pref("media.videocontrols.picture-in-picture.enabled", false);
user_pref("media.videocontrols.picture-in-picture.video-toggle.enabled", false);
user_pref("media.videocontrols.picture-in-picture.video-toggle.flyout-enabled", false);
user_pref("browser.casting.enabled", false);
// Appearance
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
user_pref("browser.tabs.tabMinWidth", 130);
user_pref("browser.tabs.tabClipWidth", 100);
// animations
user_pref("full-screen-api.warning.delay", 0);
user_pref("full-screen-api.warning.timeout", 0);

// I'm not sure if the following settings matter, but they're filled with URLs by default so they might phone home.
user_pref("signon.management.page.breachAlertUrl", "");
