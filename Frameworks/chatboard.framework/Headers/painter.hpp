#ifndef BASEPAINTER_HPP
#define BASEPAINTER_HPP

#include "common/common.h"
#include "render/include/render_api.hpp"
#include "common/color.hpp"
#include "render/base/render_attribute.hpp"
#include "render/include/sprite_sheet_info.hpp"
#include "painter_info.hpp"
#include "io/interface/chatboard_init_interface.hpp"
#include "target/render_target.hpp"

namespace chatboard::render::material {
    
    class MaterialElement;
}
namespace chatboard::render::engine
{
    enum class e_painter_type
    {
        opengl,
        opengl_es2,
        opengl_es3,
        skia,
        cpu
    };
    
    class painter:public enable_shared_from_this<painter>
    {
    public:
        painter();
        virtual ~painter() = 0;
    protected:
        int _space_width;
        int _space_height;
    public:
        virtual bool init(int _width,int _height,chatboard::interface::render_type type) = 0;
        virtual bool prepare() = 0;
        virtual bool destroy() = 0;
        virtual void viewPort(int _left,int _top,int _width,int _height) = 0;
        virtual void spaceSize(int width_,int height_);
        virtual void clear(const common::color & _color) = 0;
        
        virtual void drawElement(shared_ptr<material::MaterialElement> _element,render_attribute & _attribute)  = 0;
        
        virtual void drawRenderTarget(shared_ptr<render_target> target_,render_attribute & attribute_,const common::rect & rect_) = 0;
        virtual void recycleBuffer(shared_ptr<painter_info> _info) = 0;
        virtual void prePaint() = 0;
        virtual void afterPaint() = 0;
        
        //api for frame buffer
        virtual bool useRenderTarget(shared_ptr<render_target> target_) = 0;
        virtual shared_ptr<render_target> createRenderTarget(int width_,int height_) = 0;
        
        virtual void destroyRenderTarget(shared_ptr<render_target> target_) = 0;
        
        
    public:
        virtual void addPreloadResource(const sprite_sheet_info & info_);
        virtual void addPreloadResourcePath(const string & path_);
        virtual bool setVerticalFlip(bool _flip);
        virtual bool isVerticalFlip();
        virtual bool initialized() = 0;
        
        int space_width();
        int space_height();
        
        virtual common::rect getAtlasRect(const string  & name_) = 0;
        
        virtual bool setSteady(bool steady_);
        virtual bool steady();
        
        virtual void drawTest(){};
        
        virtual void beginCrop(const common::rect crop_,render_attribute & attribute_){};
        virtual void endCrop(){};
    public:
        static shared_ptr<painter> createPainter(int _width,int _height,chatboard::interface::render_type type,bool _isFlip);
    protected:
        interface::render_type m_renderType;
        vector<sprite_sheet_info> m_preloadResourceList;
        bool m_verticalFlip = false;
        bool m_steady = false;
    };
}
typedef std::shared_ptr<chatboard::render::engine::painter> painter_ptr;

#endif // BASEPAINTER_HPP
