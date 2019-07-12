#include "imageprovider.h"

ImageProvider::ImageProvider() : QQuickImageProvider(QQuickImageProvider::Pixmap)
{

}
QPixmap ImageProvider::requestPixmap(const QString &path, QSize *size, const QSize &requestedSize)
{
	TagLib::MPEG::File file(path.toLatin1());
	QPixmap coverArt = QPixmap();
	if (file.isValid()) {
		if (file.hasID3v2Tag()) {
			TagLib::ID3v2::Tag *tag = file.ID3v2Tag();
			TagLib::ID3v2::FrameList list = tag->frameList("APIC");
			if(!list.isEmpty()) {
				TagLib::ID3v2::FrameList::Iterator iter;
				for( iter = list.begin(); iter != list.end(); iter++ )
				{
					TagLib::ID3v2::AttachedPictureFrame *frame = static_cast<TagLib::ID3v2::AttachedPictureFrame *>(*iter);
					if( !frame ) {
						continue;
					}
					if (frame->type() == TagLib::ID3v2::AttachedPictureFrame::Type::FrontCover) {
						coverArt.loadFromData((const uchar *) frame->picture().data(), frame->picture().size());
						break;
					}
				}
			}
		}
	}
	if (size) {
		*size = QSize(coverArt.width(), coverArt.height());
	}
	coverArt.scaled(requestedSize, Qt::IgnoreAspectRatio);
	return coverArt;
}
