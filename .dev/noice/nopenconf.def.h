/* See LICENSE file for copyright and license details. */

/* {} will be substituted with the actual argument when the rule is executed */
struct rule rules[] = {
    { .regex = "\\.(avi|mp4|mkv|mp3|ogg|flac|mov)$", .file = "mpv", .argv = { "mpv", "{}", NULL } },
    { .regex = "\\.(lua|c|cpp|h|py|md|tex|txt)$", .file = "vim", .argv = { "vim", "{}", NULL } },
    { .regex = "\\.(bmp|png|jpg|gif)$", .file = "qimgv", .argv = { "qimgv", "{}", NULL } },
    { .regex = "\\.(html|svg)$", .file = "firefox", .argv = { "firefox", "{}", NULL } },
    { .regex = "\\.(pdf|ps)$", .file = "zathura", .argv = { "zathura --fork", "{}", NULL } },
    { .regex = "\\.sh$", .file = "sh", .argv = { "sh", "{}", NULL } },
    { .regex = ".", .file = "vim", .argv = { "vim", "{}", NULL } },
};
