#!/usr/bin/ruby

def mkDir(dir_name)
	directory_name = Dir::pwd + "/" + dir_name

	exist_directory = FileTest::directory?(directory_name)
	if not exist_directory
		Dir::mkdir(directory_name)
	end

end

directory_name = "meu_diretorioiii"

mkDir(directory_name)
