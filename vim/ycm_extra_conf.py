import os
import os.path
import subprocess
import logging
import ycm_core

BASE_FLAGS = [
    '-Wall',
    '-Wextra',
    '-Werror',
    #'-Wc++98-compat',
    #'-Wno-long-long',
    #'-Wno-variadic-macros',
    #'-fexceptions',
    #'-DNDEBUG',
    '-std=c++11',
    '-xc++',
    '-I/usr/include/'
]

SOURCE_EXTENSIONS = [
    '.cpp',
    '.cxx',
    '.cc',
    '.c',
    '.m',
    '.mm'
]

HEADER_EXTENSIONS = [
    '.h',
    '.hxx',
    '.hpp',
    '.hh'
]

def IsHeaderFile(filename):
    extension = os.path.splitext(filename)[1]
    return extension in HEADER_EXTENSIONS

def GetCompilationInfoForFile(database, filename):
    logging.info("Getting compilation info for file!");
    if IsHeaderFile(filename):
        basename = os.path.splitext(filename)[0]
        logging.info("Basename set!");
        for extension in SOURCE_EXTENSIONS:
            replacement_file = basename + extension
            logging.info("Replacemente file set!");
            if os.path.exists(replacement_file):
                logging.info("Path exists!");
                compilation_info = database.GetCompilationInfoForFile(replacement_file)
                logging.info("Compilation info gotten!");
                if compilation_info.compiler_flags_:
                    logging.info("Returning compilation_info");
                    return compilation_info
        return None
    logging.info("Returning database.GetCompilationInfoForFile(filename)");
    return database.GetCompilationInfoForFile(filename)

def MakeRelativePathsInFlagsAbsolute(flags, working_directory):
    if not working_directory:
        return list(flags)
    new_flags = []
    make_next_absolute = False
    path_flags = [ '-isystem', '-I', '-iquote', '--sysroot=' ]
    for flag in flags:
        new_flag = flag

        if make_next_absolute:
            make_next_absolute = False
            if not flag.startswith('/'):
                new_flag = os.path.join(working_directory, flag)

        for path_flag in path_flags:
            if flag == path_flag:
                make_next_absolute = True
                break

            if flag.startswith(path_flag):
                path = flag[ len(path_flag): ]
                new_flag = path_flag + os.path.join(working_directory, path)
                break

        if new_flag:
            new_flags.append(new_flag)
    return new_flags

def FindCompilationDatabaseDir():
    try:
        gitroot = subprocess.check_output('git rev-parse \
                                          --show-toplevel'.split()).strip().decode('utf-8')
        build_folders = ['build/', 'Build/', 'bld/']
        for folder in build_folders:
            build_dir = os.path.join(gitroot, folder)
            compilation_db_path = os.path.join(build_dir, 'compile_commands.json')
            if os.path.isdir(build_dir):
                logging.info("Found build directory: " + build_dir);
                if os.path.isfile(compilation_db_path):
                    logging.info("Found compilation database file: " +
                                 compilation_db_path)
                    break
                else:
                    logging.info("Compilation database file not found in build \
                                 folder. Ensure to set CMAKE_EXPORT_COMPILE_COMMANDS to ON")
        else:
            logging.info("No compilation database file found!")
            return None

        logging.info("Compilation database dir: " + build_dir);
        logging.info("Compilation database dirname: " +
                     os.path.dirname(build_dir));
        return os.path.dirname(build_dir)
    except:
        return None

def FlagsForCompilationDatabase(filename):
    try:
        compilation_db_dir = FindCompilationDatabaseDir()
        logging.info("Compilation database dir gotten!")
        compilation_db = ycm_core.CompilationDatabase(compilation_db_dir.encode("utf-8"))
        logging.info("Compilation database gotten!")
        if not compilation_db:
            logging.info("Compilation database file found but unable to load")
            return None
        compilation_info = GetCompilationInfoForFile(compilation_db, filename)
        if not compilation_info:
            logging.info("No compilation info for " + filename + " in \
                         compilation database")
            return None
        return MakeRelativePathsInFlagsAbsolute(
            compilation_info.compiler_flags_,
            compilation_info.compiler_working_dir_)
    except Exception, e:
        logging.info("Exception raised: " + str(e))
        return None

def FlagsForFile(filename, **kwargs):
    compilation_db_flags = FlagsForCompilationDatabase(filename)
    if compilation_db_flags:
        final_flags = compilation_db_flags
        if not '-xc++' in final_flags and not '-xc' in final_flags:
            final_flags.append('-xc++')
    else:
        final_flags = BASE_FLAGS

    return {
        'flags': final_flags,
        'do_cache': True
    }
