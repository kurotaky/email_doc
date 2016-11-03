require 'email_doc'

module EmailDoc
  class Documents
    def initialize
      @table = Hash.new {|table, key| table[key] = []}
    end
 
    def append(context, mail)
      p "===== append ====="
      p document = EmailDoc::Document.new(context.clone, mail.clone)
      @table[document.pathname] << document
      p "===== append ===== @table"
      p @table
    end
 
    def write
      p "===== write ====="
      @table.each do |pathname, documents|
        pathname.parent.mkpath
        pathname.open("w") do |file|
          p file
          file << documents.map(&:render).join("\n")
        end
      end
    end
  end
end
