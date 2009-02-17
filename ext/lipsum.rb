#!/usr/bin/env ruby1.9

def lipsum
  LIPSUMS[rand(LIPSUMS.size)]
end


LIPSUMS = <<-EOF.split(/\n+/)
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent tellus justo, fringilla eu, rhoncus eget, pulvinar ut, lectus. Phasellus tempor urna non ipsum. Donec iaculis porta augue. Pellentesque dignissim libero gravida lectus. Proin justo diam, ultrices eu, egestas in, malesuada a, turpis. Vivamus vel risus. Vivamus porta metus vel felis. Fusce lacinia libero eu magna. Suspendisse dui dolor, cursus quis, tincidunt in, vestibulum sit amet, lorem. Maecenas tempor tincidunt ligula. Vestibulum scelerisque, dolor ut porta aliquet, mi augue euismod dolor, nec aliquet sapien sem in massa. Vestibulum risus metus, bibendum pellentesque, scelerisque in, mattis ut, metus.

Sed varius pellentesque nunc. Ut vehicula. Integer arcu tellus, tempus in, adipiscing et, laoreet in, urna. Sed magna sapien, feugiat sit amet, elementum eu, suscipit eget, risus. Etiam sodales tincidunt sem. Nam metus odio, lobortis in, porta eu, sagittis vitae, mi. Morbi sodales, lacus quis lobortis vehicula, massa erat tristique nisi, eu lacinia urna leo in sem. Nulla facilisi. Vivamus porttitor convallis pede. Ut ac velit sed nunc auctor varius. Sed quis lacus ut sem porttitor fringilla. Pellentesque malesuada consequat orci. Phasellus mauris nunc, ultricies eu, malesuada quis, condimentum a, nunc.

Nullam massa. Quisque eget ipsum. Quisque enim felis, ullamcorper eu, euismod et, vulputate nec, nisl. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Fusce metus est, laoreet vel, facilisis sit amet, sodales non, nulla. Etiam dignissim ultrices nulla. Duis mollis turpis nec turpis. Nulla aliquam nisl id est. Proin elit dui, interdum ut, porta eu, lobortis sed, sapien. Pellentesque odio. Mauris sagittis sem sit amet tortor. In scelerisque nulla ac mauris. Ut volutpat nibh vel turpis. Ut aliquam. Aenean nunc lacus, gravida eget, placerat nec, fringilla ut, orci. Nam tempus.

Donec turpis risus, sollicitudin eu, scelerisque eget, pulvinar at, nulla. Aenean ligula tortor, malesuada sit amet, tempor sed, laoreet sed, felis. Nam mi. Aliquam aliquam, nunc ut bibendum consequat, diam massa faucibus erat, non porta orci enim at turpis. Curabitur tortor. Nunc sodales mauris at ante. Aenean vulputate. Phasellus vitae eros. Nullam erat felis, varius dictum, fringilla nec, laoreet faucibus, lectus. Vivamus eu ipsum in justo pretium ultricies. Morbi malesuada purus id felis. Aenean sagittis est vel magna.

In lacus quam, sagittis ut, pellentesque eget, ultrices id, sem. Mauris lobortis adipiscing lectus. Donec nisi orci, blandit id, condimentum a, euismod ac, orci. Donec risus. Cras rhoncus nisi. Phasellus semper auctor mi. Etiam augue leo, tincidunt in, dictum non, suscipit vitae, sem. Nunc a metus sit amet nisi ultrices adipiscing. Pellentesque lacinia. Sed faucibus diam iaculis orci. Sed et ligula vitae ante semper dignissim.

Pellentesque venenatis facilisis diam. Vivamus facilisis. Integer lorem diam, consectetur id, porta at, convallis at, pede. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Proin ut est. Praesent lacinia. Vestibulum turpis massa, luctus eu, porta id, euismod vel, elit. Curabitur luctus nisl nec justo commodo blandit. Maecenas non erat eget risus volutpat gravida. Aenean hendrerit sagittis erat. Nunc vitae arcu vel erat porttitor venenatis. Nunc sed pede at odio laoreet vestibulum.

Aliquam varius. Proin non odio. Praesent ac tortor a turpis posuere rutrum. Phasellus faucibus dignissim diam. Curabitur bibendum quam eu velit. Integer porttitor massa in velit. Donec vel metus eget erat dignissim rhoncus. Duis id tortor at lorem adipiscing imperdiet. Nulla facilisi. Donec turpis. Proin eget mauris.

Nam id massa. Ut id mi quis massa suscipit dictum. Praesent dapibus placerat ante. Nam placerat purus vel erat. Duis leo. Phasellus at arcu sit amet arcu cursus hendrerit. Aliquam erat volutpat. Aliquam erat volutpat. Etiam molestie consequat diam. Sed non ligula. Vestibulum pede. Aenean diam. Mauris consequat sollicitudin odio. Nunc in quam. Phasellus vitae orci. Phasellus congue erat eu pede. Ut lacus. Nam lobortis libero ac pede. Sed rhoncus augue in nulla.

Sed pharetra lobortis sem. Proin consequat ipsum quis dolor. Duis nec felis. Praesent sem diam, vestibulum id, porttitor in, eleifend et, est. Etiam a enim nec lorem pulvinar laoreet. Donec vestibulum tortor. Phasellus sed ante et pede ultrices pharetra. Nam tempus eleifend lorem. Suspendisse sapien diam, malesuada id, porttitor aliquam, mattis a, libero. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam a nisl ac est eleifend consectetur. Curabitur commodo gravida eros. Fusce congue pede vel eros. Phasellus pretium. Duis semper felis et massa. Suspendisse aliquam euismod purus. Donec condimentum dui nec mi. Etiam quis urna. Quisque at urna vel tellus elementum auctor. Fusce a enim.

Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Aliquam massa diam, varius sit amet, sodales vitae, mattis id, velit. Aenean id nisl vitae massa cursus varius. Nunc nulla sapien, blandit at, pulvinar nec, facilisis placerat, ante. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Mauris consectetur purus eget pede. Vestibulum ullamcorper tristique lacus. Nunc magna. Mauris elementum urna quis nisi. Pellentesque lobortis suscipit neque. Donec arcu. Nulla eros. Integer ac enim. Vestibulum volutpat lacinia ante. Suspendisse potenti. Praesent ultricies malesuada nunc. Phasellus pellentesque, urna non eleifend eleifend, eros diam sodales mi, sed sollicitudin urna sapien eget magna. Phasellus viverra tempus tortor. Donec dui pede, pulvinar ac, rutrum at, consequat eget, quam. Suspendisse potenti.

EOF

if __FILE__ == $0
  puts lipsum
end
