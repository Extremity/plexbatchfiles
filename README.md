# plexbatchfiles
Crappy batch files I've made for Plex stuff. Seriously, they're crap.

This is only here so if lazy people like me want to use it, they can. If I add more, I'll update this.


## [titlecards > rename.bat](https://github.com/Extremity/plexbatchfiles/blob/main/titlecards/rename.bat) (Windows only)

Takes a folder of title cards for TV episodes and moves them to the proper TV show directory, renaming them to match the episode files. I get most of mine from [r/PlexTitleCards](https://www.reddit.com/r/PlexTitleCards/). The batch script relies on a few factors:

1) Both the title cards and the TV episodes are in proper season folders, within a parent folder. The title card images and episode files do not have to be in the same folders, obviously, as that defeats the purpose.
2) The title cards are named with standard SxxExx.ext formatting. ie, S01E03.png or S10E19.jpg - this is easy to do with a tool like bulk rename utility, and most title cards come named this way. If this becomes a huge problem I might edit it to be more forgiving.
3) The title cards are in a valid Plex-accepted image format (png, jpg, jpeg, tbn)
4) The episode video files are properly named for Plex (they can be named anything you want, as long as they contain the proper SxxExx in their name as Plex requires

A proper setup, for example, could consist of two folders:

- C:\Pictures\Plex Title Cards\TV\Breaking Bad\ (title cards location)
- F:\Movies & TV\Television\Breaking Bad\ (tv episodes location)

...we call these the "parent" folders, and each one will have folders within them for each Season - Season 1, Season 2, Season 3, and so on. The parent folders do not need to have the same name, as long as the Season folders match between both locations. I can remove or ease this requirement in the future if needed (or you can do it, it's just a batch file, live a little).

Now that that's done, using it is easy.

1) Copy and paste the code from the [titlecards > rename.bat](https://github.com/Extremity/plexbatchfiles/blob/main/titlecards/rename.bat) script.
2) Paste it into a text editor of your choice and save it as "filename.bat" (without the quotes). You can call it whatever you like, as long as the extension is .bat
3) Place this file in the parent directory of your title card image files (in the example above, the "Breaking Bad" folder on drive C:)
4) Double click the .bat file to run. It will prompt you for the title card image type; select the proper one.
5) It will prompt you for the path to your episode files. In the example above, you would paste the entire "F:\Movies & TV\..." file path.
6) Wait roughly two seconds for it to complete. 

You're done! Once you've made sure everything's been moved, you can delete the title card folder for this show (all Season folders within will be empty). If there's and demand for it, I'll add an option to copy the files rather than move them.

*Why did I need this, you ask? Many of my TV show episodes (and I have a lot of them) contain unique information per episode, such as the episode title. I can't simply batch-rename the files with sequential episode numbers, and Plex requires that local media files use the exact file name of the episode. So, if I have file names like "TV Show - S04E15 - The Dog Chases the Cat [1080p WEBRip x265][Derp].mkv" and every single other episode also has a unique name, there is no easy way for me to match each title card to each episode without doing so one by one. Now, instead, I can just double click on this.*
