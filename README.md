
# Dotfiles

Personal folder containing configurations.

## Setup

Clone repository:

```bash
git clone https://github.com/LucaDeppieri/.dotfiles.git
```

## Create links to files/folders

### Unix

```bash
ln -sf *.dotfiles_location* *link_location-original_file_location*
```

### Windows

Open `cmd` with admin privilegies and use this command for each file:

```bash
mklink /H *link_location-original_file_location* *.dotfiles_location*
```

or folder:

```bash
mklink /J *link_location-original_folder_location* *.dotfiles_location*
```

