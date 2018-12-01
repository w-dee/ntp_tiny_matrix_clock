puts("

(module led_matrix_0402_48x24 (layer F.Cu) (tedit 5BECD30D)
  (fp_text reference REF** (at 0 -4.05) (layer F.SilkS)
    (effects (font (size 1 1) (thickness 0.15)))
  )
  (fp_text value led_matrix_0402_48x24 (at 0 -2.7) (layer F.Fab)
    (effects (font (size 1 1) (thickness 0.15)))
  )
")

pins = Hash.new

for y in (0..13) do
	for x in (0..47) do
		xx = x * 1.83
		yy = y * 2

		group = sprintf("%02d", x / 16)
		com_index = sprintf("%02d", x % 8)
		bundle = sprintf("%02d", x % 16 / 8 * 14 + y)
		
		pa = "a#{group}#{com_index}"
		pk = "k#{group}#{bundle}"
		pins[pa] = 1
		pins[pk] = 1

		n = "

  (fp_line (start 0.25617 -0.202954) (end 0.25617 0.297046) (layer F.SilkS) (width 0.15))
  (fp_line (start -0.24383 0.297046) (end -0.24383 -0.202954) (layer F.SilkS) (width 0.15))
  (fp_line (start -0.24383 0.297046) (end 0.25617 0.297046) (layer F.SilkS) (width 0.15))
  (pad #{pk} smd roundrect (at 0.00617 0.597046 270) (size 0.4 0.5) (layers F.Cu F.Paste F.Mask) (roundrect_rratio 0.25))
  (pad #{pa} smd roundrect (at 0.00617 -0.502954 270) (size 0.4 0.5) (layers F.Cu F.Paste F.Mask) (roundrect_rratio 0.25))
		"

		puts n.gsub( /\((start|end|at)\s+([-0-9.]+)\s+([-0-9.]+)/ ) { |match|
			"(#{$1} #{xx+$2.to_f} #{yy+$3.to_f}" }

	end
end		

puts("
)
")

idx = 0
pins.keys.sort.each do |key|
	STDERR.puts("X #{key} #{key} #{idx*50} -1000 200 U 24 24 1 1 I")
	idx = idx + 1
end



