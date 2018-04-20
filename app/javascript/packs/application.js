require.context('../images', true, /\.(png|jpg|jpeg|svg)$/)

import '../stylesheets/application';
import 'bootstrap/dist/js/bootstrap';
import 'expose-loader?$!jquery';
import './filefield_text';
import './image_preview';

import Rails from 'rails-ujs';
Rails.start()