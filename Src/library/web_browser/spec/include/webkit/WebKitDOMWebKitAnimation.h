/*
    This file is part of the WebKit open source project.
    This file has been generated by generate-bindings.pl. DO NOT MODIFY!

    This library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Library General Public
    License as published by the Free Software Foundation; either
    version 2 of the License, or (at your option) any later version.

    This library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    Library General Public License for more details.

    You should have received a copy of the GNU Library General Public License
    along with this library; see the file COPYING.LIB.  If not, write to
    the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
    Boston, MA 02110-1301, USA.
*/

#ifndef WebKitDOMWebKitAnimation_h
#define WebKitDOMWebKitAnimation_h

#include "webkit/webkitdomdefines.h"
#include <glib-object.h>
#include <webkit/webkitdefines.h>
#include "webkit/WebKitDOMObject.h"


G_BEGIN_DECLS
#define WEBKIT_TYPE_DOM_WEBKIT_ANIMATION            (webkit_dom_webkit_animation_get_type())
#define WEBKIT_DOM_WEBKIT_ANIMATION(obj)            (G_TYPE_CHECK_INSTANCE_CAST((obj), WEBKIT_TYPE_DOM_WEBKIT_ANIMATION, WebKitDOMWebKitAnimation))
#define WEBKIT_DOM_WEBKIT_ANIMATION_CLASS(klass)    (G_TYPE_CHECK_CLASS_CAST((klass),  WEBKIT_TYPE_DOM_WEBKIT_ANIMATION, WebKitDOMWebKitAnimationClass)
#define WEBKIT_DOM_IS_WEBKIT_ANIMATION(obj)         (G_TYPE_CHECK_INSTANCE_TYPE((obj), WEBKIT_TYPE_DOM_WEBKIT_ANIMATION))
#define WEBKIT_DOM_IS_WEBKIT_ANIMATION_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE((klass),  WEBKIT_TYPE_DOM_WEBKIT_ANIMATION))
#define WEBKIT_DOM_WEBKIT_ANIMATION_GET_CLASS(obj)  (G_TYPE_INSTANCE_GET_CLASS((obj),  WEBKIT_TYPE_DOM_WEBKIT_ANIMATION, WebKitDOMWebKitAnimationClass))

struct _WebKitDOMWebKitAnimation {
    WebKitDOMObject parent_instance;
};

struct _WebKitDOMWebKitAnimationClass {
    WebKitDOMObjectClass parent_class;
};

WEBKIT_API GType
webkit_dom_webkit_animation_get_type (void);

/**
 * webkit_dom_webkit_animation_play:
 * @self: A #WebKitDOMWebKitAnimation
 *
 * Returns:
 *
**/
WEBKIT_API void
webkit_dom_webkit_animation_play(WebKitDOMWebKitAnimation* self);

/**
 * webkit_dom_webkit_animation_pause:
 * @self: A #WebKitDOMWebKitAnimation
 *
 * Returns:
 *
**/
WEBKIT_API void
webkit_dom_webkit_animation_pause(WebKitDOMWebKitAnimation* self);

/**
 * webkit_dom_webkit_animation_get_name:
 * @self: A #WebKitDOMWebKitAnimation
 *
 * Returns:
 *
**/
WEBKIT_API gchar*
webkit_dom_webkit_animation_get_name(WebKitDOMWebKitAnimation* self);

/**
 * webkit_dom_webkit_animation_get_duration:
 * @self: A #WebKitDOMWebKitAnimation
 *
 * Returns:
 *
**/
WEBKIT_API gdouble
webkit_dom_webkit_animation_get_duration(WebKitDOMWebKitAnimation* self);

/**
 * webkit_dom_webkit_animation_get_elapsed_time:
 * @self: A #WebKitDOMWebKitAnimation
 *
 * Returns:
 *
**/
WEBKIT_API gdouble
webkit_dom_webkit_animation_get_elapsed_time(WebKitDOMWebKitAnimation* self);

/**
 * webkit_dom_webkit_animation_set_elapsed_time:
 * @self: A #WebKitDOMWebKitAnimation
 * @value: A #gdouble
 *
 * Returns:
 *
**/
WEBKIT_API void
webkit_dom_webkit_animation_set_elapsed_time(WebKitDOMWebKitAnimation* self, gdouble value);

/**
 * webkit_dom_webkit_animation_get_delay:
 * @self: A #WebKitDOMWebKitAnimation
 *
 * Returns:
 *
**/
WEBKIT_API gdouble
webkit_dom_webkit_animation_get_delay(WebKitDOMWebKitAnimation* self);

/**
 * webkit_dom_webkit_animation_get_paused:
 * @self: A #WebKitDOMWebKitAnimation
 *
 * Returns:
 *
**/
WEBKIT_API gboolean
webkit_dom_webkit_animation_get_paused(WebKitDOMWebKitAnimation* self);

/**
 * webkit_dom_webkit_animation_get_ended:
 * @self: A #WebKitDOMWebKitAnimation
 *
 * Returns:
 *
**/
WEBKIT_API gboolean
webkit_dom_webkit_animation_get_ended(WebKitDOMWebKitAnimation* self);

/**
 * webkit_dom_webkit_animation_get_direction:
 * @self: A #WebKitDOMWebKitAnimation
 *
 * Returns:
 *
**/
WEBKIT_API gushort
webkit_dom_webkit_animation_get_direction(WebKitDOMWebKitAnimation* self);

/**
 * webkit_dom_webkit_animation_get_fill_mode:
 * @self: A #WebKitDOMWebKitAnimation
 *
 * Returns:
 *
**/
WEBKIT_API gushort
webkit_dom_webkit_animation_get_fill_mode(WebKitDOMWebKitAnimation* self);

G_END_DECLS

#endif /* WebKitDOMWebKitAnimation_h */
