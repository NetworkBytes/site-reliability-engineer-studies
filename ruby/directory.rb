require 'find'

class Directory

  def Directory.get_folders (vars)
    ret= []
    basedir = vars.has_key?("basedir") ? vars["basedir"] : '.'

    Find.find(basedir) { |e|
      if vars.has_key?(:create_time)
        ret<<e if File.ctime(e) > vars[:create_time]
        next
      end
      ret<<e if File.file?(e) and vars.has_key?(:include_files)
      ret<<e if File.directory?(e) and vars.has_key?(:include_dirs)
    }
    return(ret)
  end

  def Directory.delete_files(vars)
    Find.find(vars["basedir"]) { |e|
      if File.file?(e) and File.ctime(e) > vars[:create_time]
        puts "File.Delete() :>" + e
        #File.delete()
      end
    }
  end

end

# GET_FOLDERS
options={
  :include_files => nil,
  :include_dirs  => nil,
  "basedir"      => File.expand_path("../../", File.dirname(__FILE__)),
  :create_time   => Time.now - (60 * 60 * 24)
}
puts Directory.get_folders(options)

# REMOVE FILES
opt2 = {
  :create_time => Time.now - (60 * 10),
  "basedir"    => File.dirname(__FILE__)
}
Directory.delete_files(opt2)
