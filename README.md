# SelectaVue IPTV player

SelectaVue manages and plays M3U playlists with a simple interface that can be quickly and easily navigated.

## 🎯 Features

- **Simple list** - Easily navigate and flip through channels across multiple playlists
- **Multiple M3U playlists** - Save new playlist and quickly switch between these
- **Channel surf** - Switch channels with up and down arrows while watching TV
- **Quick menu** - Press ← and browse through playlist channels without pausing the video
- **Preview** - See the selected channel in thumbnail format as you browse the channel list
- **Audio options** - Change the audio track/language during playback
- **Subtitles** - Turn subtitles on/off when available
- **Full screen** - 1920x1080 video with no black borders
- **Multi-format** - HLS, MP4, MKV, AVI and more than 20 formats


## 📥 Tnstallation

https://developer.roku.com/dev/docs/developer-setup

## 🎮 Controls

### Main menu

| Button           | Action                                             |
| ---------------- | -------------------------------------------------- |
| **←→**           | Switch between playlist menu and channel list      |
| **↑↓**           | Browse playlists or channels                       |
| **OK**           | Play selected channel                              |
| **Options (\*)** | Add new M3U playlist                               |
| **Replay**       | Reload current channel                             |

> **Preview:** When browsing the channels, you'll see a thumbnail preview on the right. Use → to toggle mute.
### During  fullscreen playback

| Button               | Action                                                  |
| -------------------- | ------------------------------------------------------- |
| **OK**               | Open options menu (audio, subtitles, info)              |
| **Play/Pause**       | Pause or resume video                                   |
| **Instant Replay**   | Reload the current channel (useful if video was paused) |
| **←**                | Show/hide the quick menu (video continues playing)      |
| **↑ / Rewind**       | Channel surf to previous channel in playlist            |
| **↓ / Fast Forward** | Channel surf to next channel in playlist                |
| **Back**             | Return to main menu                                     |

### Options menu (press OK while playing)

- 🔊 **Change Audio** - Select the audio track/language
- 💬 **Subtitles** - Turn subtitles on or off
- ℹ️ **Channel Info** - Displays information about the current channel
- ❌ **Close** - Closes the options menu
> **Tip:** The channels are cyclical - the last one connects to the first one

> **Tip:** Tip: If the video freezes or pauses, press **Instant Replay** (⏪) to reload the channel.

## 📺 Personal playlists

Use your own M3U playlist or your IPTV provider's URL. Supported formats:

- URLs (HTTP/HTTPS)
- M3U format with EXTINF labels
- Channel groups (group-title)

### Predefined lists

The app includes lists of free channels for:

- 🇺🇸 United States
- 🇨🇦 Canada
- 🇦🇺 Australia
- 🇬🇧 United Kingdom
- 🇯🇵 Japan
- 🇰🇷 Korea

### Add custom list
1. Select "➕ Add List" in the playlists menu
2. Enter a name for your list
3. Enter the URL of your M3U playlist (must include http: or https:)
4. Done! Your list will now appear in the menu

**Playlist recommendations:**

- [M3U.cl](https://m3u.cl/) - Listings by country
- [IPTV-ORG](https://github.com/iptv-org/iptv) - Global colletction

## 🔧 Troubleshooting

**The app closes on startup:**

- Check your internet connection
- Try a smaller playlist first.

**The playlist is not loading:**

- Verify that the URL is accessible from a browser
- Make sure the format is a valid M3U
- Try the default demo playlist

**No audio tracks appear:**

- Wait a few seconds after the channel starts playing
- Not all channels have multiple audio tracks
- Press OK to see the available options

**The channel is showing an error:**

- Channels gon on and offline, some channels may be temporarily unavailable.
- Use ↑↓ to switch to another channel without closing anything

**Debug:**

```bash
telnet TU_IP_ROKU 8085
```

## 📋 Version

- **Current version:** Still in alpha stage
- **Last updated:** June 13, 2026

## 📄 Legal documentation

- [Privacy Policy](PRIVACY_POLICY.md)
- [Terms of Service](TERMS_OF_SERVICE.md)

## 📧 Contact

- Email: grizzsoft@gmail.com
- GitHub: https://github.com/Grizzly-Adam/SelectaVue
