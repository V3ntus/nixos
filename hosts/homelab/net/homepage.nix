{
  services.glance = {
    enable = true;
    openFirewall = true;
    settings = {
      pages = [
        {
          name = "Home";
          head-widgets = [
            {
              type = "markets";
              hide-header = true;
              markets = [
                {
                  symbol = "SPY";
                  name = "S&P 500";
                }
                {
                  symbol = "VT";
                  name = "Vanguard Total World";
                }
                {
                  symbol = "VTI";
                  name = "Vanguard Total Stock";
                }
                {
                  symbol = "VOO";
                  name = "Vanguard S&P ETF";
                }
                {
                  symbol = "VGT";
                  name = "Vanguard Info Tech ETF";
                }
              ];
            }
          ];
          columns = [
            {
              size = "small";
              widgets = [
                {
                  type = "clock";
                  hour-format = "24h";
                }
                {
                  type = "weather";
                  units = "imperial";
                  hour-format = "24h";
                  location = "Denver, Colorado, United States";
                }
                {
                  type = "to-do";
                }
                {
                  type = "calendar";
                }
              ];
            }
            {
              size = "full";
              widgets = [
                {
                  type = "videos";
                  style = "grid-cards";
                  channels = [
                    "UCRDGoUiPVitiB6Ks_esR7rg" # Therm
                    "UCFKDEp9si4RmHFWJW1vYsMA" # EthosLab
                    "UCNLRcEn78Vc62C3GkMvBgtA" # Saveitforparts
                    "UCyMnHssVup_wBZRnCSMVt3w" # CHRBRG
                  ];
                  limit = 20;
                  collapse-after-rows = 2;
                }
                {
                  type = "bookmarks";
                  groups = [
                    {
                      links = [
                        {
                          title = "Gmail";
                          url = "https://mail.google.com/mail/u/0/";
                        }
                        {
                          title = "PrivateEmail";
                          url = "https://privateemail.com/appsuite/";
                        }
                        {
                          title = "Amazon";
                          url = "https://amazon.com";
                        }
                        {
                          title = "Github";
                          url = "https://github.com";
                        }
                      ];
                    }
                    {
                      title = "Entertainment";
                      color = "10 70 50";
                      links = [
                        {
                          title = "Netflix";
                          url = "https://netflix.com";
                        }
                        {
                          title = "Disney+";
                          url = "https://disneyplus.com";
                        }
                        {
                          title = "YouTube";
                          url = "https://youtube.com";
                        }
                        {
                          title = "Prime Video";
                          url = "https://primevideo.com";
                        }
                      ];
                    }
                    {
                      title = "Social";
                      color = "200 50 50";
                      links = [
                        {
                          title = "Reddit";
                          url = "https://reddit.com";
                        }
                        {
                          title = "Instagram";
                          url = "https://instagram.com";
                        }
                      ];
                    }
                  ];
                }
              ];
            }
            {
              size = "small";
              widgets = [
                {
                  type = "group";
                  widgets = [
                    {
                      type = "rss";
                      title = "Cooking";
                      style = "vertical-list";
                      feeds = [
                        {
                          url = "https://www.budgetbytes.com/feed/";
                          title = "BudgetBytes";
                        }
                      ];
                    }
                    {
                      type = "rss";
                      title = "News";
                      style = "vertical-list";
                      feeds = [
                        {
                          url = "https://news.ycombinator.com/rss";
                          title = "YCombinator";
                        }
                      ];
                    }
                  ];
                }
                {
                  type = "custom-api";
                  title = "Steam Specials";
                  cache = "24h";
                  url = "https://store.steampowered.com/api/featuredcategories?cc=us";
                  template = ''
                    <ul class="list list-gap-10 collapsible-container" data-collapse-after="5">
                    {{ range .JSON.Array "specials.items" }}
                      <li>
                        <a class="size-h4 color-highlight block text-truncate" href="https://store.steampowered.com/app/{{ .Int "id" }}/">{{ .String "name" }}</a>
                        <ul class="list-horizontal-text">
                          <li>{{ div (.Int "final_price" | toFloat) 100 | printf "$%.2f" }}</li>
                          {{ $discount := .Int "discount_percent" }}
                          <li{{ if ge $discount 40 }} class="color-positive"{{ end }}>{{ $discount }}% off</li>
                        </ul>
                      </li>
                    {{ end }}
                    </ul>
                  '';
                }
              ];
            }
          ];
        }
        {
          name = "Apps";
          head-widgets = [
            {
              type = "split-column";
              widgets = [
                {
                  type = "clock";
                  title = null;
                  hour-format = "24h";
                }
                {
                  type = "custom-api";
                  title = "Random Verse";
                  cache = "3h";
                  url = "https://bible-api.com/data/web/random";
                  template = ''
                    <p class="size-h2 color-highlight">{{ .JSON.String "random_verse.book" }} {{ .JSON.String "random_verse.chapter" }}:{{ .JSON.String "random_verse.verse" }}</p>
                        <p class="size-h4 color-paragraph">{{ .JSON.String "random_verse.text" }}</p>
                  '';
                }
              ];
            }
          ];
          columns = [
            {
              size = "full";
              widgets = [
                {
                  type = "group";
                  widgets = [
                    {
                      type = "custom-api";
                      title = "Next Up";
                      frameless = true;
                      cache = "5m";
                      options = {
                        base-url = "https://jellyfin.gladiusso.com";
                        api-key = "6c07b730a3cb4016a051e7931ff5ff60";
                        user-name = "admin";
                        library-name = "shows";
                        mode = "nextup";
                        item-count = "10";
                        small-column = false;
                        show-thumbnail = true;
                        thumbnail-aspect-ratio = "default";
                      };
                      template = ''
                                        {{/* Required config options */}}
                        {{ $baseURL := .Options.StringOr "base-url" "" }}
                        {{ $apiKey := .Options.StringOr "api-key" "" }}
                        {{ $userName := .Options.StringOr "user-name" "" }}

                        {{/* Required config options for "latest" mode */}}
                        {{ $libraryName := .Options.StringOr "library-name" "" }}

                        {{/* Optional config options */}}
                        {{ $mode := .Options.StringOr "mode" "latest" }}
                        {{ $itemCount := .Options.StringOr "item-count" "10" }}
                        {{ $mediaTypes := .Options.StringOr "media-types" "Movie,Episode,MusicAlbum" }}
                        {{ $thumbAspectRatio := .Options.StringOr "thumbnail-aspect-ratio" "" }}
                        {{ $isSmallColumn:= .Options.BoolOr "small-column" false }}
                        {{ $showThumbnail := .Options.BoolOr "show-thumbnail" false }}
                        {{ $showProgressBar := .Options.BoolOr "progress-bar" true }}

                        {{/* Error message template */}}
                        {{ define "errorMsg" }}
                          <div class="widget-error-header">
                            <div class="color-negative size-h3">ERROR</div>
                            <svg class="widget-error-icon" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5">
                              <path stroke-linecap="round" stroke-linejoin="round" d="M12 9v3.75m-9.303 3.376c-.866 1.5.217 3.374 1.948 3.374h14.71c1.73 0 2.813-1.874 1.948-3.374L13.949 3.378c-.866-1.5-3.032-1.5-3.898 0L2.697 16.126ZM12 15.75h.007v.008H12v-.008Z"></path>
                            </svg>
                          </div>
                          <p class="break-all">{{ . }}</p>
                        {{ end }}

                        {{/* Check required fields */}}
                        {{ if or (eq $baseURL "") (eq $apiKey "") (eq $userName "") (eq $mode "") (and (eq $mode "latest") (eq $libraryName "")) }}
                          {{ template "errorMsg" "Some required options are not set." }}
                        {{ else }}

                          {{/* Fetch user ID */}}
                          {{ $userID := "" }}
                          {{ $usersCall := newRequest (print $baseURL "/Users")
                              | withParameter "api_key" $apiKey
                              | withHeader "Accept" "application/json"
                              | getResponse }}

                          {{ range $i, $user := $usersCall.JSON.Array "" }}
                            {{ if eq ($user.String "Name") $userName }}
                              {{ $userID = $user.String "Id" }}
                              {{ break }}
                            {{ end }}
                          {{ end }}
                          {{ if eq $userID "" }}
                            {{ template "errorMsg" (printf "User '%s' not found." $userName) }}
                          {{ else }}

                            {{ $items := "" }}

                            {{ if eq $mode "latest" }}

                              {{/* Fetch library ID */}}
                              {{ $libraryID := "" }}
                              {{ $userViewsCall := newRequest (print $baseURL "/UserViews")
                                  | withParameter "api_key" $apiKey
                                  | withParameter "userId" $userID
                                  | withHeader "Accept" "application/json"
                                  | getResponse }}

                              {{ range $i, $item := $userViewsCall.JSON.Array "Items" }}
                                {{ if eq ($item.String "Name") $libraryName }}
                                  {{ $libraryID = $item.String "Id" }}
                                  {{ break }}
                                {{ end }}
                              {{ end }}

                              {{ if eq $libraryID "" }}
                                {{ template "errorMsg" (printf "Library '%s' not found." $libraryName) }}
                              {{ else }}
                                {{/* Fetch latest items */}}
                                {{ $latestCall := newRequest (print $baseURL "/Users/" $userID "/Items/Latest")
                                    | withParameter "api_key" $apiKey
                                    | withParameter "Limit" $itemCount
                                    | withParameter "ParentId" $libraryID
                                    | withParameter "IncludeItemTypes" $mediaTypes
                                    | withParameter "GroupItems" "true"
                                    | withHeader "Accept" "application/json"
                                    | getResponse }}
                                {{ $items = $latestCall.JSON.Array "" }}
                              {{ end }}

                            {{ else if eq $mode "nextup" }}

                              {{/* Fetch next up items */}}
                              {{ $nextUpCall := newRequest (print $baseURL "/Shows/NextUp")
                                | withParameter "api_key" $apiKey
                                | withParameter "UserId" $userID
                                | withParameter "Limit" $itemCount
                                | withParameter "EnableResumable" "true"
                                | withHeader "Accept" "application/json"
                                | getResponse }}
                              {{ $items = $nextUpCall.JSON.Array "Items" }}

                            {{ else }}
                              {{ template "errorMsg" "Unknown mode, expected 'latest' or 'nextup'" }}
                            {{ end }}

                            {{ if eq (len $items) 0 }}
                              <p>No items found, start streaming something!</p>
                            {{ else }}

                              {{/* Display the item carousel */}}
                              <div class="carousel-container show-right-cutoff">
                                <div class="cards-horizontal carousel-items-container">
                                  {{ range $n, $item := $items }}
                                    {{/* Common item variables */}}
                                    {{ $mediaType := $item.String "Type" }}
                                    {{ $title := $item.String "Name" }}
                                    {{ $itemID := $item.String "Id" }}

                                    {{/* Media type specific variables */}}
                                    {{ $seriesTitle := "" }}
                                    {{ $artist := "" }}
                                    {{ $seriesID := "" }}
                                    {{ $season := "" }}
                                    {{ $episode := "" }}
                                    {{ $playPercentage := "" }}
                                    {{ $unwatchedEpisodeCount := "" }}

                                    {{ if eq $mediaType "Movie" }}
                                    {{ else if eq $mediaType "Series" }}
                                      {{ $unwatchedEpisodeCount = $item.Int "UserData.UnplayedItemCount" }}
                                    {{ else if eq $mediaType "Episode" }}
                                      {{ $unwatchedEpisodeCount = 1 }}
                                      {{ $seriesTitle = $item.String "SeriesName" }}
                                      {{ $seriesID = $item.String "SeriesId" }}
                                      {{ $season = $item.Int "ParentIndexNumber" }}
                                      {{ $episode = $item.Int "IndexNumber" }}

                                      {{ if $item.Exists "UserData.PlayedPercentage" }}
                                        {{ $playPercentage = $item.String "UserData.PlayedPercentage" }}
                                      {{ end }}

                                      {{/* For latest always refer to the series not individual episodes */}}
                                      {{ if eq $mode "latest" }}
                                        {{ $itemID = $seriesID }}
                                        {{ $title = $seriesTitle }}
                                      {{ end }}
                                    {{ else if eq $mediaType "MusicAlbum" }}
                                      {{ $artist = $item.String "AlbumArtist" }}
                                    {{ end }}

                                    {{ $linkURL := print $baseURL "/web/#/details?id=" $itemID }}
                                    {{ $thumbURL := "" }}
                                    {{ if not (eq $playPercentage "") }}
                                      {{/* $thumbURL = concat $baseURL "/Items/" $itemID "/Images/Primary?api_key=" $apiKey "&percentPlayed=" $playPercentage */}}
                                      {{ $thumbURL = concat $baseURL "/Items/" $itemID "/Images/Primary?api_key=" $apiKey }}
                                    {{ else }}
                                      {{ $thumbURL = concat $baseURL "/Items/" $itemID "/Images/Primary?api_key=" $apiKey }}
                                    {{ end }}

                                    <a class="card widget-content-frame" href="{{ $linkURL | safeURL }}">
                                      {{ if $showThumbnail }}
                                        <div style="position: relative;">
                                          <img src="{{ $thumbURL | safeURL }}"
                                            alt="{{ $title }} thumbnail"
                                            loading="lazy"
                                            class="media-server-thumbnail shrink-0"
                                            style="
                                              object-fit: fill;
                                              border-radius: var(--border-radius) var(--border-radius) 0 0;
                                              width: 100%;
                                              display: block;
                                              {{ if eq $thumbAspectRatio "square" }}aspect-ratio: 1;
                                              {{ else if eq $thumbAspectRatio "portrait" }}aspect-ratio: 2/3;
                                              {{ else if eq $thumbAspectRatio "landscape" }}aspect-ratio: 16/9;
                                              {{ else }}aspect-ratio: initial;
                                              {{ end }}
                                            "
                                          />

                                          {{ if and ($showProgressBar) (not (eq $playPercentage "")) }}
                                            <div style="
                                              position: absolute;
                                              bottom: 8px;
                                              left: 8px;
                                              right: 8px;
                                              height: 6px;
                                              border-radius: var(--border-radius);
                                              overflow: hidden;
                                              background-color: rgba(255, 255, 255, 0.2);
                                            ">
                                              <div style="
                                                width: {{ print $playPercentage "%" }};
                                                height: 100%;
                                                border-radius: var(--border-radius) 0 0 var(--border-radius);
                                                background-color: var(--color-primary)
                                              "></div>
                                            </div>
                                          {{ end }}
                                        </div>
                                      {{ end }}

                                      <div class="grow padding-inline-widget margin-top-10 margin-bottom-10">
                                        <ul class="flex flex-column justify-evenly margin-bottom-3 {{ if $isSmallColumn }}size-h6{{ end }}" style="height: 100%;">
                                          {{ if eq $mode "latest" }}
                                            {{ if or (eq $mediaType "Series") (eq $mediaType "Episode") }}
                                              <ul class="list-horizontal-text flex-nowrap">
                                                <li class="color-primary shrink-0">{{ $unwatchedEpisodeCount }}</li>
                                                <li class="text-truncate">{{ $title }}</li>
                                              </ul>
                                            {{ else if eq $mediaType "MusicAlbum" }}
                                              <ul class="list-horizontal-text flex-nowrap">
                                                <li class="color-primary text-truncate">{{ $artist }}</li>
                                                <li class="text-truncate">{{ $title }}</li>
                                              </ul>
                                            {{ else }}
                                              <li class="text-truncate">{{ $title }}</li>
                                            {{ end }}
                                          {{ else if eq $mode "nextup" }}
                                            <ul class="list-horizontal-text flex-nowrap">
                                              <li class="color-primary shrink-0">S{{ $season }}E{{ $episode }}</li>
                                              <li class="text-truncate">{{ $seriesTitle }}</li>
                                            </ul>
                                            <li class="text-truncate">{{ $title }}</li>
                                          {{ end }}
                                        </ul>
                                      </div>
                                    </a>
                                  {{ end }}
                                </div>
                              </div>
                            {{ end }}

                          {{ end }}

                        {{ end }}
                      '';
                    }
                  ];
                }
                {
                  type = "group";
                  widgets = [
                    {
                      type = "custom-api";
                      title = "NFL Scoreboard";
                      cache = "15s";
                      url = "https://site.api.espn.com/apis/site/v2/sports/football/nfl/scoreboard";
                      template = ''
                                          {{- $fallback := "/assets/default-team-logo.png" -}}

                        <ul class="list list-gap-10 collapsible-container" data-collapse-after="5">
                         {{ range .JSON.Array "events" }}
                          <li>
                             {{ $competitions := .Array "competitions" }}
                             {{ if gt (len $competitions) 0 }}
                              {{ $comp0 := index $competitions 0 }}
                              {{ $competitors := $comp0.Array "competitors" }}
                              {{ if ge (len $competitors) 2 }}
                                {{ $c0 := index $competitors 0 }}
                                {{ $c1 := index $competitors 1 }}

                                {{ $short := $comp0.String "status.type.shortDetail" }}
                                {{ $state := $comp0.String "status.type.state" }}

                                <div style="display:flex; gap:10px; padding:8px 0;">

                                  <div style="width:30px; font-weight:bold; font-size: 11px; display:flex; align-items:center;">
                                    {{- if eq $short "Scheduled" -}}
                                      {{- $date := $comp0.String "date" -}}
                                      <span style="color:#aaa;">
                                        {{ printf "%s:%s" (slice $date 11 13) (slice $date 14 16) }}
                                      </span>
                                    {{- else if eq $state "in" -}}
                                      <span style="color:#00c853;">{{ $comp0.String "status.displayClock" }}</span>
                                    {{- else if eq $short "Postponed" -}}
                                      <span style="color:#aaa;">Post.</span>
                                    {{- else if eq $short "Canceled" -}}
                                      <span style="color:#aaa;">Canc.</span>
                                    {{- else -}}
                                      <span style="color:#aaa;">{{ $short }}</span>
                                    {{- end }}
                                  </div>

                                  <div style="flex:1; display:flex; flex-direction:column; gap:6px;">

                                    {{- $logo0 := $c0.String "team.logo" -}}
                                    <div style="display:flex; align-items:center; justify-content:space-between; width:100%;">
                                      <div style="display:flex; align-items:center; gap:6px; min-width:0; flex:1;">
                                          {{ if ne $logo0 "" }}
                                            <img src="{{ $logo0 }}" width="24" height="24" style="flex-shrink:0;">
                                          {{ else }}
                                            <img src="{{ $fallback }}" width="24" height="24" style="flex-shrink:0;">
                                          {{ end }}
                                          <span style="white-space:nowrap; overflow:hidden; text-overflow:ellipsis; min-width:0;">
                                              {{ $c0.String "team.shortDisplayName" }}
                                          </span>
                                      </div>
                                      <span style="font-weight:700;">{{ $c0.String "score" }}</span>
                                    </div>

                                    {{- $logo1 := $c1.String "team.logo" -}}
                                    <div style="display:flex; align-items:center; justify-content:space-between; width:100%;">
                                      <div style="display:flex; align-items:center; gap:6px; min-width:0;">
                                        {{ if ne $logo1 "" }}
                                          <img src="{{ $logo1 }}" width="24" height="24" style="flex-shrink:0;">
                                        {{ else }}
                                          <img src="{{ $fallback }}" width="24" height="24" style="flex-shrink:0;">
                                        {{ end }}
                                        <span style="white-space:nowrap; overflow:hidden; text-overflow:ellipsis; min-width:0;">
                                          {{ $c1.String "team.shortDisplayName" }}
                                        </span>
                                      </div>
                                      <span style="font-weight:700;">{{ $c1.String "score" }}</span>
                                    </div>

                                  </div>

                                </div>
                              {{ end }}
                             {{ end }}
                           </li>
                         {{ end }}
                        </ul>
                      '';
                    }
                  ];
                }
              ];
            }
          ];
        }
        {
          name = "System";
          columns = [
            {
              size = "full";
              widgets = [
                {
                  type = "split-column";
                  widgets = [
                  ];
                }
              ];
            }
          ];
        }
      ];

      server = {
        proxied = true;
        host = "0.0.0.0";
        port = 8082;
      };

      branding = {
        app-name = "CS30 Home";
      };

      theme = {
        # Gruvbox dark
        background-color = "0 0 16";
        primary-color = "43 59 81";
        positive-color = "61 66 44";
        negative-color = "6 96 59";
      };
    };
  };
}
