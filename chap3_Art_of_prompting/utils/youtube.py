from youtube_transcript_api import YouTubeTranscriptApi

def get_transcript(video_id):
    """
    Fetches the transcript of a YouTube video given its ID.
    Ex
    Args:
        video_id (str): The ID of the YouTube video.
        
    Returns:
        str: The transcript of the video in WebVTT format.
    """
    try:
        # Fetch the transcript
        transcript = YouTubeTranscriptApi.get_transcript(video_id)
        processed_text = " ".join(entry['text'].replace('\n', ' ') for entry in transcript)
        return processed_text
    except Exception as e:
        print(f"Error fetching transcript: {e}")
        return "Error fetching transcript"