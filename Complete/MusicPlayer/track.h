#ifndef TRACK_H
#define TRACK_H

#include <QObject>
#include <QDir>
#include <QString>
#include <QImage>
#include <taglib/taglib.h>
#include <taglib/mpegfile.h>
#include <taglib/mpegproperties.h>
#include <taglib/id3v2tag.h>
#include <taglib/attachedpictureframe.h>


class Track : public QObject
{
	Q_OBJECT

	Q_PROPERTY(QString path READ getPath WRITE setPath)
	Q_PROPERTY(QString title READ getTitle)
	Q_PROPERTY(QString artist READ getArtist)
	Q_PROPERTY(QString album READ getAlbum)
	Q_PROPERTY(QString duration READ getDuration)
	Q_PROPERTY(QImage coverArt READ getCoverArt)
	Q_PROPERTY(bool isValid READ isValid)

public:
	explicit Track(QObject *parent = nullptr);

	QString getPath();
	QString getTitle();
	QString getArtist();
	QString getAlbum();
	QString getDuration();
	QImage getCoverArt();
	bool isValid();

private:
	void setPath(QString);

private:
	QString m_path;
	QString m_title;
	QString m_artist;
	QString m_album;
	QString m_duration;
	QImage m_coverArt;
	bool m_isValid;
};

#endif // TRACK_H
