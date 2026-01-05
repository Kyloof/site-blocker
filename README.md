# Linux Site Blocker

Very simple and lightweight site blocker that modifies `/etc/hosts` to temporarily restrict access to distracting websites. 

NOTE: Because the script will interact with `/etc/hosts`, it'll require sudo access. The entire script is very short, see file: `block.sh`

## Installation
1. Download or clone this repository.
2. Open a terminal inside the project folder.
3. Run the following commands to move the files to the system library and create the executable link:

```bash
sudo mv site-blocker /usr/local/lib/
sudo chown -R root:root /usr/local/lib/site-blocker
sudo ln -s /usr/local/lib/site-blocker/block.sh /usr/local/bin/block
```

## Usage

Run the command followed by the block profile name and the duration in minutes.

**Syntax:**

```bash
block [profile_name] [minutes]
```

**Examples:**

```bash 
# Block 'socials' for 60 minutes 
block socials 60

# Block 'news' for 30 minutes in the background
block news 30 &
```

To stop a background block early, bring it to the foreground with `fg` and press `Ctrl+C`, or identify the process ID and kill it. The script will automatically clean up and restore the hosts file upon exit.

### Creating Block Profiles

Block profiles are text files located in `/usr/local/lib/site-blocker/block_profiles/`. To add a new list of sites to block:

#### Create a new file in the options directory (requires root permissions):

```bash
sudo vim /usr/local/lib/site-blocker/block_profiles/my_new_list
```

#### Add the domains you wish to block pointing to `127.0.0.1`

**Format:**

```text 
127.0.0.1 www.facebook.com
127.0.0.1 www.youtube.com
127.0.0.1 www.instagram.com 
```

## Uninstallation

To remove the tool from your system:

```bash 
# Remove the symlink 
sudo rm /usr/local/bin/block

# Remove the source files
sudo rm -rf /usr/local/lib/site-blocker
```
