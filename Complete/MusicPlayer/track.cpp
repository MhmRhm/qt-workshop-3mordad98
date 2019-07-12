#include "track.h"

Track::Track(QObject *parent) : QObject(parent),
	m_isValid(false)
{
}
QString Track::getPath()
{
	return m_path;
}
QString Track::getTitle()
{
	return m_title;
}
QString Track::getArtist()
{
	return m_artist;
}
QString Track::getAlbum()
{
	return m_album;
}
QString Track::getDuration()
{
	return m_duration;
}
QImage Track::getCoverArt()
{
	return m_coverArt;
}
bool Track::isValid() {
	return m_isValid;
}
void Track::setPath(QString path) {
	m_path = path.remove(0, 7);
	TagLib::MPEG::File file(path.toLatin1());
	TagLib::MPEG::Properties properties(&file);
	if (file.isValid()) {
		if (file.hasID3v2Tag()) {
			TagLib::ID3v2::Tag *tag = file.ID3v2Tag();
			m_title = QString(tag->title().toCString());
			m_artist = QString(tag->artist().toCString());
			m_album = QString(tag->album().toCString());
			m_duration = QString::number(properties.lengthInSeconds()/60).append(":").append(QString::number(properties.lengthInSeconds()%60));
			m_coverArt = QImage();
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
						m_coverArt.loadFromData((const uchar *) frame->picture().data(), frame->picture().size());
						break;
					}
				}
			}
			m_isValid = true;
		}
		else {
			return;
		}
	}
	else {
		return;
	}
}
