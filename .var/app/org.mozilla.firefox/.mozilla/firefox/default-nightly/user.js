// This user.js WILL create more fingerprinting vectors. However, most third-party surveillance modules take very little of this into account.
// If you really want to reduce fingerprinting potential, use the tor browser.
// My priority here is attack surface reduction, not anonymity. Again, use the Tor Browser for anonymity.
// I use FF for attack surface reduction, Chromium for securely using apps with lots of attack surface, and the Tor Browser for anonymity.

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
user_pref("browser.search.geoip.url", "");
user_pref("browser.search.geoSpecificDefaults.url", "");
user_pref("browser.selfsupport.url", "");
user_pref("browser.chrome.errorReporter.infoURL", "");
user_pref("browser.chrome.errorReporter.publicKey", "");
user_pref("browser.aboutHomeSnippets.updateUrL", "");
user_pref("browser.startup.homepage_override.buildID", "");
user_pref("browser.startup.homepage", "");
user_pref("startup.homepage_welcome_url", "");
user_pref("startup.homepage_welcome_url.additional", "");
user_pref("startup.homepage_override_url", "");
user_pref("browser.startup.homepage_override.mstone", "ignore");
user_pref("browser.search.countryCode", "US"); // (hidden pref)
user_pref("browser.search.region", "US"); // (hidden pref)
user_pref("general.useragent.locale", "en-US");
user_pref("browser.search.geoSpecificDefaults", false);
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
/// disale captive portal phoning home to detectportal.firefox.com; I handle captive portals separately.
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
user_pref("browser.library.activity-stream.topSiteSearchShortcuts", false);
user_pref("browser.newtabpage.activity-stream.discoverystream.personalization.modelKeys", "");
user_pref("browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts.searchEngines", "");
user_pref("browser.newtabpage.pinned", "");
user_pref("browser.newtabpage.activity-stream.fxaccounts.endpoint", "");
user_pref("browser.newtabpage.activity-stream.default.sites", "");
user_pref("browser.newtabpage.activity-stream.asrouter.providers.whats-new-panel", "");
user_pref("browser.newtabpage.activity-stream.asrouter.providers.snippets", "");
user_pref("browser.newtabpage.activity-stream.asrouter.providers.onboarding", "");
user_pref("browser.newtabpage.activity-stream.asrouter.providers.cfr-fxa", "");
user_pref("browser.newtabpage.activity-stream.asrouter.providers.cfr", "");
user_pref("browser.newtabpage.activity-stream.discoverystream.config", "");
user_pref("browser.newtabpage.activity-stream.feeds.section.topstories.options", "");
user_pref("browser.newtabpage.activity-stream.telemetry.structuredIngestion.endpoint", "");
user_pref("browser.onboarding.notification.tour-ids-queue", "");
user_pref("lightweightThemes.getMoreURL", "");
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
user_pref("browser.uitour.enabled", false);
user_pref("browser.uitour.url", "");

/*disable builtin extensions*/
user_pref("extensions.pocket.enabled", false);
user_pref("extensions.pocket.site", "");
user_pref("extensions.pocket.oAuthConsumerKey", "");
user_pref("extensions.pocket.api", "");
user_pref("extensions.screenshots.disabled", true);
user_pref("extensions.screenshots.upload-disabled", true);
user_pref("extensions.autoDisableScopes", 15);
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
user_pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false);
user_pref("browser.newtabpage.activity-stream.disableSnippets", true);
user_pref("browser.newtabpage.activity-stream.telemetry.ping.endpoint", "");
user_pref("browser.topsites.contile.enabled", false);
user_pref("browser.topsites.contile.endpoint", "");
user_pref("browser.partnerlink.attributionURL", "");
user_pref("browser.partnerlink.campaign.topsites", "");

// misc privacy
user_pref("privacy.firstparty.isolate", true);
user_pref("privacy.firstparty.isolate.block_post_message", true);
user_pref("browser.sessionrestore.privacy_level", 2);

user_pref("browser.urlbar.speculativeConnect.enabled", false);

/*Deny most permissions*/
user_pref("permissions.default.camera", 2);
user_pref("permissions.default.desktop-notification", 2);
user_pref("permissions.default.geo", 2);
user_pref("permissions.default.microphone", 2);
user_pref("permissions.isolateBy.userContext", true);
user_pref("privacy.userContext.ui.enabled", true);

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
user_pref("browser.safebrowsing.provider.mozilla.lists", "");
user_pref("browser.safebrowsing.provider.mozilla.lists.base", "");
user_pref("browser.safebrowsing.provider.mozilla.lists.content", "");

// Disable firefox accounts; just use a dotfile manaager and rsync the extensions.
user_pref("identity.fxaccounts.remote.root", "");
user_pref("identity.fxaccounts.pairing.enabled", false);
user_pref("identity.fxaccounts.pairing.uri", "");
user_pref("identity.fxaccounts.enabled", false);
user_pref("identity.sync.tokenserver.uri", "");
user_pref("webextensions.storage.sync.serverURL", "");
user_pref("webchannel.allowObject.urlWhitelist", "");
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
//user_pref("network.trr.mode", 5);
//user_pref("network.trr.resolvers", "");
//user_pref("network.trr.bootstrapAddress", "");
//user_pref("network.trr.uri", "");
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

// via https://support.mozilla.org/en-US/kb/how-stop-firefox-making-automatic-connections
user_pref("extensions.webextensions.restrictedDomains", "");
user_pref("network.prefetch-next", false);
user_pref("network.dns.disablePrefetch", true);
user_pref("network.http.speculative-parallel-limit", 0);
user_pref("network.predictor.enabled", false);
user_pref("messaging-system.rsexperimentloader.enabled", false);
user_pref("app.normandy.optoutstudies.enabled", false);
user_pref("app.normandy.enabled", false);
user_pref("extensions.getAddons.cache.enabled", false);
user_pref("media.gmp-gmpopenh264.enabled", false);
user_pref("browser.casting.enabled", false);
user_pref("network.connectivity-service.enabled", false);
// user_pref("layout.css.devPixelsPerPx", "1.0");

// HTTPS-first
user_pref("dom.security.https_first", true);
user_pref("dom.security.https_first_pbm", false);
user_pref("dom.targetBlankNoOpener.enabled", true);
user_pref("network.IDN_show_punycode", true);
user_pref("network.cookie.cookieBehavior", 1);
user_pref("network.cookie.thirdparty.sessionOnly", true);
user_pref("network.cookie.thirdparty.nonsecureSessionOnly", true); // [FF58+]

user_pref("app.update.background.scheduling.enabled", false);

user_pref("browser.cache.offline.storage.enable", false);
user_pref("offline-apps.allow_by_default", false);
user_pref("privacy.clearOnShutdown.cache", true);
user_pref("privacy.clearOnShutdown.downloads", true); // see note above
user_pref("privacy.clearOnShutdown.offlineApps", true); // Offline Website Data
user_pref("privacy.clearOnShutdown.siteSettings", false); // Site Preferences

user_pref("browser.menu.showViewImageInfo", true);

// some prefs from torbutton
user_pref("javascript.options.ion", false);
user_pref("javascript.options.baselinejit", false);
user_pref("javascript.options.native_regexp", false);
user_pref("javascript.options.asmjs", false);
user_pref("javascript.options.wasm", false);

user_pref("dom.event.clipboardevents.enabled", false);
user_pref("dom.event.clipboardevents.enabled", false);
user_pref("dom.vibrator.enabled", false);
// user_pref("dom.allow_cut_copy", false);
user_pref("dom.event.contextmenu.enabled", false);
user_pref("network.http.referer.XOriginPolicy", 2);
user_pref("network.http.referer.trimmingPolicy", 2);
user_pref("network.http.referer.XOriginTrimmingPolicy", 2);
user_pref("browser.cache.disk.capacity", 0);
user_pref("browser.cache.disk.enable", false);
// I have no reason to use something besides en-us.
user_pref("privacy.spoof_english", true);
user_pref("javascript.use_us_english_locale", true);
user_pref("intl.accept_languages", "en-US, en");
user_pref("dom.webaudio.enabled", false);
user_pref("browser.download.forbid_open_with", true);
user_pref("security.OCSP.enabled", 1); // ocsp is good for security, but please use stapling. I'm trading some priv for sec.
user_pref("security.OCSP.require", true); // ocsp is good for security, but please use stapling. I'm trading some priv for sec.
user_pref("browser.preferences.experimental", true); // doesn't do anything, just exposes a convenient menu in prefs.

// https://bugzilla.mozilla.org/show_bug.cgi?id=1672013
user_pref("widget.non-native-theme.enabled", true);
user_pref("security.sandbox.content.headless", true);
user_pref("security.ssl.treat_unsafe_negotiation_as_broken",	true);
user_pref("security.mixed_content.upgrade_display_content", true);
user_pref("security.mixed_content.block_object_subrequest", true);
user_pref("security.mixed_content.block_display_content", true);
user_pref("security.mixed_content.block_active_content", true);

// why isn't this default
user_pref("browser.ctrlTab.sortByRecentlyUsed", false);
user_pref("browser.download.animateNotifications", false);

user_pref("browser.bookmarks.autoExportHTML", true);
user_pref("dom.payments.request.enable", false);
user_pref("browser.translation.engine", "");

user_pref("html5.offmainthread", true); //default true
user_pref("layers.offmainthreadcomposition.enabled", true);
user_pref("layers.offmainthreadcomposition.async-animations", true);
user_pref("browser.display.use_document_fonts", 0);
user_pref("gfx.downloadable_fonts.enabled", false);
// user_pref("gfx.downloadable_fonts.disable_cache", true);

user_pref("webgl.disabled", true);
user_pref("webgl.dxgl.enabled", false); // [WINDOWS]
user_pref("webgl.enable-webgl2", false);
/* 2012: limit WebGL ***/
user_pref("webgl.min_capability_mode", true);
user_pref("webgl.disable-extensions", true);
user_pref("webgl.disable-fail-if-major-performance-caveat", true);
/* 2022: disable screensharing ***/
user_pref("media.getusermedia.screensharing.enabled", false);
user_pref("media.getusermedia.browser.enabled", false);
user_pref("media.getusermedia.audiocapture.enabled", false);

// disable some stuff I don't need/use but can get annoyed by.
user_pref("dom.enable_resource_timing", false);
user_pref("dom.enable_performance", false);
user_pref("device.sensors.enabled", false);
user_pref("dom.gamepad.enabled", false);
user_pref("dom.netinfo.enabled", false); // [DEFAULT: true on Android]
user_pref("media.webspeech.synth.enabled", false);
user_pref("media.video_stats.enabled", false);
user_pref("dom.w3c_touch_events.enabled", 0);
user_pref("media.ondevicechange.enabled", false);
user_pref("webgl.enable-debug-renderer-info", false);
user_pref("dom.w3c_pointer_events.enabled", false);
user_pref("dom.battery.enabled", false);
user_pref("geo.enabled", false);
user_pref("geo.wifi.uri", "");
user_pref("dom.serviceWorkers.enabled", false); // use chromium for more advanced webshit
user_pref("browser.send_pings", false); // why is this a feature
user_pref("browser.urlbar.trimURLs", false); // why is this a feature
user_pref("media.autoplay.default", 1); // thanks adtech for making me do this shit. you people are making the world a better place.
user_pref("browser.tabs.drawInTitlebar", false); // let the WM/Compositor handle decorations, stop trying to do everything yourself. ugh.
user_pref("security.ssl.disable_session_identifiers", true); // common tracking vector

// WHY IS THERE ADWARE ON MY COMPUTER. WTF.
user_pref("browser.urlbar.suggest.quicksuggest", false);
user_pref("browser.urlbar.suggest.quicksuggest.sponsored", false);
user_pref("browser.newtabpage.activity-stream.discoverystream.sponsored-collections.enabled", false);
user_pref("browser.newtabpage.activity-stream.discoverystream.spocAdTypes", "");
user_pref("browser.newtabpage.activity-stream.discoverystream.spocSiteId", "");
user_pref("browser.newtabpage.activity-stream.discoverystream.spocZoneIds", "");
// IDK what this is, but I block all cookie banners so I can't consent to them lol.
// Assuming that browsing the website == consent is illegal and plenty of sites still
// do it, but I cbf to find a good workaround. This isn't a real workaround since it
// can still pick "accept all" automatically, WTF
user_pref("cookiebanners.bannerClicking.enabled", false);
user_pref("cookiebanners.ui.desktop.enabled", false);

user_pref("pdfjs.enableScripting", false);

// gpu accel
user_pref("layers.gpu-process.enabled", true);
user_pref("gfx.webrender.all", true);
user_pref("media.gpu-process-decoder", true);
user_pref("widget.wayland-dmabuf-vaapi.enabled", true);

user_pref("extensions.manifestV3.enabled", true);
user_pref("privacy.query_stripping.enabled", true);
user_pref("privacy.globalprivacycontrol.enabled", true);
user_pref("privacy.globalprivacycontrol.functionality.enabled", true);
user_pref("privacy.partition.network_state.ocsp_cache", true);

// isolation
user_pref("dom.block_external_protocol_navigation_from_sandbox", true);
user_pref("dom.ipc.processCount.webIsolated", 8);
user_pref("dom.ipc.processCount", 16);
user_pref("fission.webContentIsolationStrategy", 1);
// the following pref breaks most extensions
// user_pref("security.sandbox.gpu.level", 1); // text rendering is broken when value set to "2"
user_pref("security.sandbox.socket.process.level", 1);


// IDK if this works on all platforms yet
user_pref("security.sandbox.content.shadow-stack.enabled", true	);
user_pref("security.sandbox.gmp.shadow-stack.enabled", true	);
user_pref("security.sandbox.gpu.shadow-stack.enabled", true	);
user_pref("security.sandbox.rdd.shadow-stack.enabled", true	);
user_pref("security.sandbox.socket.shadow-stack.enabled", true);

// more mozilla bloatware
user_pref("browser.tabs.firefox-view", false);
user_pref("services.sync.prefs.sync.browser.firefox-view.feature-tour", false);
user_pref("browser.firefox-view.feature-tour", "");
// I'll use a weather app/widget if I want to, but outside the browser
user_pref("browser.urlbar.suggest.weather", false);

// I deal with overstim, so I like to disable animations
// disable animations
user_pref("ui.prefersReducedMotion", 1);

// disable migrations
user_pref("browser.migrate.brave.enabled", false);
user_pref("browser.migrate.canary.enabled", false);
user_pref("browser.migrate.chrome-beta.enabled", false);
user_pref("browser.migrate.chrome-dev.enabled", false);
user_pref("browser.migrate.chrome.enabled", false);
user_pref("browser.migrate.chromium-360se.enabled", false);
user_pref("browser.migrate.chromium-edge-beta.enabled", false);
user_pref("browser.migrate.chromium-edge.enabled", false);
user_pref("browser.migrate.chromium.enabled", false);
user_pref("browser.migrate.edge.enabled", false);
user_pref("browser.migrate.firefox.enabled", false);
user_pref("browser.migrate.ie.enabled", false);
user_pref("browser.migrate.opera.enabled", false);
user_pref("browser.migrate.safari.enabled", false);

// more bloat

user_pref("browser.tabs.firefox-view", false);
user_pref("browser.tabs.firefox-view-next", false);
user_pref("browser.aboutwelcome.enabled", false);
user_pref("dom.push.enabled", false);
user_pref("dom.webmidi.enabled", false);
user_pref("dom.vr.enabled", false);
user_pref("javascript.options.shared_memory", false);

// perf
user_pref("nglayout.initialpaint.delay", 50);
user_pref("nglayout.initialpaint.delay_in_oopif", 50);
user_pref("gfx.webrender.precache-shaders", true);
user_pref("gfx.webrender.compositor", true);
user_pref("gfx.webrender.compositor.force-enabled", true);
user_pref("network.http.max-connections", 1800); // default=900
user_pref("browser.low_commit_space_threshold_percent", 25); // default=5;


// PREF: Smartblock
// [1] https://support.mozilla.org/en-US/kb/smartblock-enhanced-tracking-protection
// [2] https://www.youtube.com/watch?v=VE8SrClOTgw
// [3] https://searchfox.org/mozilla-central/source/browser/extensions/webcompat/data/shims.js
user_pref("extensions.webcompat.enable_shims", true); // enabled with "Strict"


// PREF: disable remote debugging
// [1] https://gitlab.torproject.org/tpo/applications/tor-browser/-/issues/16222
user_pref("devtools.debugger.remote-enabled", false); // DEFAULT

// no TLS bypass
user_pref("security.cert_pinning.enforcement_level", 2);
user_pref("security.enterprise_roots.enabled", false);

user_pref("_userjs.parsed.correctly", "SUCCESS");
