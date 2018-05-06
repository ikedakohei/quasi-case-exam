require.context('../images', true, /\.(png|jpg|jpeg|svg)$/)

import '../stylesheets/application';
import 'bootstrap/dist/js/bootstrap';
import 'expose-loader?$!jquery';
import './filefield_text';
import './image_preview';

import 'bootstrap4-datetimepicker/src/js/bootstrap-datetimepicker';
import './datetimepicker';

import Rails from 'rails-ujs';
Rails.start()