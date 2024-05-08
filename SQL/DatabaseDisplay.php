<!DOCTYPE html>
<html>
	<head>
		<title>W3.CSS Template</title>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>Discworld Header</title>
		<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
		<link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Roboto'>
		<link rel="stylesheet" href='https://fonts.googleapis.com/css?family=Noto+Serif'>
		<style>
			.header-container {
            display: flex;
            align-items: center;
        	}

        	.header-container img {
            width: 25%;
            height: auto;
            margin-right: 20px; /* Adjust the margin as needed */
        	}
        body {
            font-family: 'Noto Serif', sans-serif;
            background-color: #272727; /* Dark background */
            color: #ffffff; /* Light text color */
            margin: 0;
        }

        h1, h2, h3, h4, h5, h6 {
            color: #ffcc00; /* Golden heading color */
        }

        a {
            color: #ffcc00; /* Golden link color */
        }

        a:hover {
            color: #ffd699; /* Lighter golden color on hover */
        }

        .w3-container {
            background-color: #272727; /* Dark container background */
            color: #ffffff; /* Light text color */
            padding: 20px;
            border-radius: 10px;
            margin-top: 20px;
        }

        .w3-two-third {
            background-color: #272727; /* Slightly lighter background for main content */
            color: #ffffff; /* Light text color */
            padding: 20px;
            border-radius: 10px;
            margin-top: 20px;
        }

        table {
            border-collapse: collapse;
            border-spacing: 0;
            width: 90%;
            border: 2px solid #555; /* Dark border color for tables */
            margin-top: 20px;
        }

        th, td {
            text-align: left;
            padding: 16px;
            border-bottom: 2px solid #555; /* Dark border color for table rows */
        }

        tr:nth-child(even) {
            background-color: #333; /* Dark row background color */
        }
    </style>
	</head>
	<body>
		
		
		<!-- Use this section to connect to your database. -->
		<?php 
			$con = mysqli_connect("localhost","root","", "Discworld");
			
			if (mysqli_connect_errno()) {
				echo "Failed to connect to MySQL: " . mysqli_connect_error();
				exit();
			}
		?>		
		
		<!-- Header section -->
		<div class="w3-container w3-blue-grey header-container">
        <img src="https://d4804za1f1gw.cloudfront.net/wp-content/uploads/sites/18/2019/09/Discworld_BlogPost_1024x768.png" alt="Discworld Image">
        <h1>INFS 657: Database design &amp; management</h1>
			
		</div>
		
		<div style="width: 96%; margin:auto;">
		<!-- Left column section -->
		<div class="w3-third" style="height: 1500px;">
			<h2>Discworld Db</h2>
			<p>Discworld Db is a database of books, ebooks, and audiobooks of Terry Prachett's Disworld.</p>
			<p>Created for your enjoyment by Amanda, Arzah, Dina, and Michelle :-)
				
			<div>
			<!--number of editions (simple count)-->
				<?php
        			if ($result = mysqli_query($con, "SELECT COUNT(Edition_ID) AS edition_count FROM EDITION")) {
            			$edition_count = mysqli_fetch_array($result);
            			mysqli_free_result($result);
            			echo "<p>Edition count is: " . $edition_count['edition_count'] . "!</p>";
        			}
    			?>
			<!--number of books with a first edition-->	
				<?php
					$query ="select count(distinct bookisbn) as editioncount from edition, story, edition_dimension " .
							"where story.title = edition.story_id " .
							"and edition_dimension.edition_id = edition.edition_id " .
							"and edition.firsted = 1";
					
					if ($result = mysqli_query($con, $query)) {
            			$edition_count = mysqli_fetch_array($result);
            			mysqli_free_result($result);
            			echo "<p>Number of books with a first edition: " . $edition_count['editioncount'] . "!</p>";
					}
				?>
			<!--most prolific cover artist (book)-->
				<?php
					$query ="select count(edition_id) as book, concat(cover_artist.artfirstname, ' ', cover_artist.artlastname) as artist " .
							"from cover_artist, cover_art, edition " .
							"where cover_art.cover_artist_id = cover_artist.cover_artist_id " .
							"and edition.cover_art_id = cover_art.cover_art_id " .
							"and not cover_artist.artfirstname = 'Unknown' " .
							"group by artist " .
							"order by book desc " .
							"limit 1";
					
					if ($result = mysqli_query($con, $query)) {
            			$edition_count = mysqli_fetch_array($result);
            			mysqli_free_result($result);
            			echo "<p>Most prolific cover artist (book): " . $edition_count['artist'] . ", with " . $edition_count['book'] . " covers!</p>";
					}
				?>	
			<!--most prolific cover artist (audiobook)-->
				<?php
					$query ="select count(audio_book_id) as audio, concat(cover_artist.artfirstname, ' ', cover_artist.artlastname) as artist " .
							"from cover_artist, cover_art, audio_book " .
							"where cover_art.cover_artist_id = cover_artist.cover_artist_id " .
							"and audio_book.cover_art_id = cover_art.cover_art_id " .
							"and not cover_artist.artfirstname = 'Unknown' " .
							"group by artist " .
							"order by audio desc " .
							"limit 1";
					
					if ($result = mysqli_query($con, $query)) {
            			$edition_count = mysqli_fetch_array($result);
            			mysqli_free_result($result);
            			echo "<p>Most prolific cover artist (audiobook): " . $edition_count['artist'] . ", with " . $edition_count['audio'] . " covers!</p>";
					}
				?>	
			</div>
			
		</div>
		
		
		
<!-- Right column section -->
		<div class="w3-two-third">
		
<!--Searchbar table-->
			<h2>What editions are available?</h2>	
			<p>Filter your search based on some choices: </p>
			
			<!-- Get input from the user to filter results -->
			<form action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>" method="post">
				<label for="bookFormat">Book Format:</label>
        		<select name="bookFormat" id="bookFormat">
            	<option value="Hardcover">Hardcover</option>
            	<option value="Paperback">Paperback</option>
            	<option value="Ebook">Ebook</option>
        		</select>

        <label for="title">Title:</label>
        <input type="text" id="title" name="title" value="" required>

        <input type="submit" name="submit" value="Search">
    </form>

    <br>

    <div style="height: 500px; overflow:auto;">
        <?php
            if ($_SERVER["REQUEST_METHOD"] == "POST") {
                $bookFormat = $_POST['bookFormat'];
                $title = $_POST['title'];

                $query = "SELECT STORY.Title, STORY.Copyright, PUBLISHER.PublisherName, concat(cover_artist.artfirstname, ' ', cover_artist.artlastname) as artist
				FROM STORY, Publisher, Edition, publication, PUBLISHER_IMPRINT, Edition_Dimension, dimensions, cover_art, cover_artist
				Where STORY.Title = EDITION.Story_ID
				and EDITION.Publication_ID = publication.publication_ID
				and publication.PUBLISHER_IMPRINT_ID = PUBLISHER_IMPRINT.PUBLISHER_IMPRINT_ID
				and PUBLISHER_IMPRINT.PUBLISHER_ID = PUBLISHER.PUBLISHER_ID
				and Edition.Edition_ID = Edition_Dimension.Edition_ID
				and Edition_Dimension.Dimensions_ID = DIMENSIONS.Dimensions_ID
				and cover_art.cover_artist_id = cover_artist.cover_artist_id
				and edition.cover_art_id = cover_art.cover_art_id
				and DIMENSIONS.BookFormat = '$bookFormat'
				AND Story.Title like '%$title%'
				";
			

                if ($result = mysqli_query($con, $query)) {
                    echo '<table><tr><th>Title</th><th>Year</th><th>Publisher</th><th>Cover Artist</th></tr>';
                    while ($row = mysqli_fetch_array($result)) {
                        $bookTitle = $row['Title'];
                        $year = $row['Copyright'];
                        $publisher = $row['PublisherName'];
                        $coverartist = $row['artist'];

                        echo '<tr><td>' . $bookTitle . '</td><td>' . $year . '</td><td>' . $publisher . '</td><td>' . $coverartist . '</td></tr>';
                    }
                    echo '</table>';

                    // Free result set
                    mysqli_free_result($result);
                } else {
                    echo "<div>Error in the query: " . mysqli_error($con) . "</div>";
                }
            }
        ?>	
</div>
<br>
<div style="height: 500px; overflow:auto;">
<!--Audiobook Information table-->
			<div>
    			<h2>Audiobook Information</h2>
    			<?php
				// Query to Count Audiobooks
					$countAudiobooksQuery = "SELECT COUNT(*) AS audiobook_count FROM AUDIO_BOOK";

				// Execute the query
					if ($countAudiobooksResult = mysqli_query($con, $countAudiobooksQuery)) {
						// Fetch the result
						$countAudiobooksRow = mysqli_fetch_assoc($countAudiobooksResult);
			
						// Output the count
						$audiobookCount = $countAudiobooksRow['audiobook_count'];
						echo "<p>There are $audiobookCount audiobooks.</p>";
			
						// Free result set
						mysqli_free_result($countAudiobooksResult);
					} else {
						echo "<div>Error in the audiobook count query: " . mysqli_error($con) . "</div>";
					}
        		// New Query to Retrieve Audiobook Information
        			$audiobookQuery = "SELECT AUDIO_BOOK.STORY_ID, STORY.Title, COVER_ART.Cover, AUDIO_BOOK.ReleaseYear, AUDIO_FORMAT.AudioFormat, AUDIO_BOOK.RecordingLength
					FROM AUDIO_BOOK
					JOIN STORY ON AUDIO_BOOK.STORY_ID = STORY.Title
					LEFT JOIN COVER_ART ON AUDIO_BOOK.COVER_ART_ID = COVER_ART.Cover_Art_ID
					LEFT JOIN AUDIO_FORMAT ON AUDIO_BOOK.AUDIO_BOOK_ID = AUDIO_FORMAT.AUDIO_BOOK_ID
					ORDER BY STORY.Title ASC";

        			if ($audiobookResult = mysqli_query($con, $audiobookQuery)) {
            			echo '<table><tr><th>Title</th><th>Cover Art</th><th>Release Year</th><th>Audio Format</th><th>Recording Length</th></tr>';
            			while ($audiobookRow = mysqli_fetch_array($audiobookResult)) {
                			$audiobookTitle = $audiobookRow['Title'];
                			$coverArt = base64_encode($audiobookRow['Cover']);
                			$releaseYear = $audiobookRow['ReleaseYear'];
                			$audioFormat = $audiobookRow['AudioFormat'];
                			$recordingLength = $audiobookRow['RecordingLength'];

                			echo '<tr>';
                			echo '<td>' . $audiobookTitle . '</td>';
                			echo '<td><img src="data:image/jpeg;base64,' . $coverArt . '" width="25%" height="25%" alt="Cover Art"></td>';
                			echo '<td>' . $releaseYear . '</td>';
                			echo '<td>' . $audioFormat . '</td>';
                			echo '<td>' . $recordingLength . '</td>';
                			echo '</tr>';
            			}
            			echo '</table>';

            // Free result set
           				 mysqli_free_result($audiobookResult);
        			} else {
            			echo "<div>Error in the audiobook query: " . mysqli_error($con) . "</div>";
        			}
    			?>
			</div>	
</div>
<br>			
<div style="height: 500px; overflow:auto;">
<!--Audiobook Narration Information table-->
    			<h2>Audiobook Narration Information</h2>
    			<?php
				// Query to Count Narrators
					$countNarratorsQuery = "SELECT COUNT(DISTINCT NARRATOR.NARRATOR_ID) AS narrator_count
					FROM AUDIO_BOOK
					JOIN NARRATION ON AUDIO_BOOK.AUDIO_BOOK_ID = NARRATION.AUDIO_BOOK_ID
					JOIN NARRATOR ON NARRATION.NARRATOR_ID = NARRATOR.NARRATOR_ID";

					// Execute the query
					if ($countNarratorsResult = mysqli_query($con, $countNarratorsQuery)) {
					// Fetch the result
					$countNarratorsRow = mysqli_fetch_assoc($countNarratorsResult);

					// Output the count
					$narratorCount = $countNarratorsRow['narrator_count'];
					echo "<p>There are $narratorCount narrators.</p>";

					// Free result set
					mysqli_free_result($countNarratorsResult);
					} else {
					echo "<div>Error in the narrator count query: " . mysqli_error($con) . "</div>";
					}
					

        		// Query to Retrieve Audiobook Narration Information
        			$narrationQuery = "SELECT STORY.Title, CONCAT(NARRATOR.NarFirstName, ' ', NARRATOR.NarLastName) AS Narrators, NARRATION.Role
					FROM AUDIO_BOOK
					JOIN STORY ON AUDIO_BOOK.STORY_ID = STORY.Title
					JOIN NARRATION ON AUDIO_BOOK.AUDIO_BOOK_ID = NARRATION.AUDIO_BOOK_ID
					JOIN NARRATOR ON NARRATION.NARRATOR_ID = NARRATOR.NARRATOR_ID
					ORDER BY STORY.Title ASC";

        			if ($narrationResult = mysqli_query($con, $narrationQuery)) {
            			echo '<table><tr><th>Title</th><th>Narrators</th><th>Role</th></tr>';
            			while ($narrationRow = mysqli_fetch_array($narrationResult)) {
                			$title = $narrationRow['Title'];
                			$narrators = $narrationRow['Narrators'];
                			$role = $narrationRow['Role'];

                			echo '<tr>';
                			echo '<td>' . $title . '</td>';
                			echo '<td>' . $narrators . '</td>';
                			echo '<td>' . $role . '</td>';
                			echo '</tr>';
           				 }
           				 echo '</table>';

            // Free result set
            			mysqli_free_result($narrationResult);
        			} else {
            			echo "<div>Error in the audiobook narration query: " . mysqli_error($con) . "</div>";
       	 			}
    			?>
</div>
<br>
<div style="height: 500px; overflow:auto;">
<!--First Edition? table-->
			<h2>First Edition?</h2>				
				<?php
					$query = "select story.title, publisher.publishername, CASE WHEN EDITION.FirstEd = 1 THEN 'Yes' ELSE 'No' END AS FirstEdition
					from story, publisher, edition, publication, publisher_imprint
					where story.title=edition.story_id
					and edition.PUBLICATION_ID = publication.PUBLICATION_ID
					and publication.PUBLISHER_IMPRINT_ID = publisher_imprint.PUBLISHER_IMPRINT_ID
					and publisher_imprint.PUBLISHER_ID = PUBLISHER.PUBLISHER_ID
					group by story.title, publisher.publishername, publisher_imprint.imprintname, FirstEdition, edition.publication_id";
					
					if ($result = mysqli_query($con, $query)) {
						echo '<table><tr><th>Title</th><th>Publisher</th><th>First?</th></tr>';
						while($row = mysqli_fetch_array($result)){
							$title = $row['title'];
							$publishername = $row['publishername'];
							$FirstEdition = $row['FirstEdition'];
						
							echo '<tr>';
							echo '<td>' . $title. '</td>';
                			echo '<td>' . $publishername . '</td>';
                			echo '<td>' . $FirstEdition . '</td>';
                			echo '</tr>';
						}
						echo '</table>';
						
						// Free result set
						mysqli_free_result($result);
					}
				?>
				
</div>
</br>
<!-- Arzah's Tables -->
<div style="height: 500px; overflow:auto;">
<!--Publication Information table-->
    			<h2>Publication Information</h2>
    			<?php
                    // Query to list publishers, their imprint and the count of the amount of books they have in our database

                    $query = 
                        "select count(edition_dimension.bookisbn) as BooksPublished, PUBLISHER.PublisherName, PUBLISHER_IMPRINT.ImprintName
							from PUBLISHER, publisher_imprint, publication, edition, edition_dimension
							where PUBLISHER_IMPRINT.PUBLISHER_ID = PUBLISHER.PUBLISHER_ID
							and PUBLICATION.PUBLISHER_IMPRINT_ID = PUBLISHER_IMPRINT.PUBLISHER_IMPRINT_ID
							and publication.publication_id = EDITION.Publication_ID
							and edition_dimension.edition_ID = edition.edition_ID
							GROUP BY PUBLISHER.PublisherName, PUBLISHER_IMPRINT.ImprintName
							order by PUBLISHER.PublisherName asc;"
							;

					// Executing the query
                    $result = mysqli_query($con, $query);


                    if ($result) {
                        echo '<table><tr><th>Publisher Name</th><th>Imprint Name</th><th>Books Published</th></tr>';
                        while ($row = mysqli_fetch_array($result)) {
                            $publisherName = $row['PublisherName'];
                            $imprintName = $row['ImprintName'];
                            $booksPublished = $row['BooksPublished'];

                            echo '<tr><td>' . $publisherName . '</td><td>' . $imprintName . '</td><td>' . $booksPublished . '</td></tr>';
                        }
                        echo '</table>';

                        // Free result set
                        mysqli_free_result($result);

					// Displays an error message if the query fails
                    } else {
                        echo "<div>Error in the query: " . mysqli_error($con) . "</div>";
                    }

                    ?>

</div>
<br>
<div style="height: 500px; overflow:auto;">
<!--Book Size Information And Edition Status table-->

                <h2>Book Size Information And Edition Status</h2>
              <?php
				// Query to display book information such as size, width and pages. Also lets user know if it's a first edition

				$query = 
				// I did kind of like an if else statement to check if the novel is a first edition and if it is it will say Yes and if not it says No
				// I just thought it looked better than having 0's and 1's
					"SELECT STORY.Title, CASE WHEN EDITION.FirstEd = 1 THEN 'Yes' ELSE 'No' END AS FirstEdition, SIZE.Height, SIZE.Width, SIZE.Pages
					FROM STORY
					INNER JOIN EDITION ON STORY.Title = EDITION.Story_ID
					INNER JOIN EDITION_DIMENSION ON EDITION.Edition_ID = EDITION_DIMENSION.Edition_ID
					INNER JOIN DIMENSIONS ON EDITION_DIMENSION.Dimensions_ID = DIMENSIONS.Dimensions_ID
					INNER JOIN SIZE ON DIMENSIONS.Size_ID = SIZE.Size_ID;"
				;
				// executing the query
				$result = mysqli_query($con, $query);

				if ($result) {
					echo '<table><tr><th>Title</th><th>Is First Edition</th><th>Height</th><th>Width</th><th>Pages</th></tr>';
					while ($row = mysqli_fetch_array($result)) {
						$title = $row['Title'];
						$FirstEdition = $row['FirstEdition'];
						$height = $row['Height'];
						$width = $row['Width'];
						$pages = $row['Pages'];

						echo '<tr><td>' . $title . '</td><td>' . $FirstEdition . '</td><td>' . $height . '</td><td>' . $width . '</td><td>' . $pages . '</td></tr>';
					}
					echo '</table>';

					// Free result set
					mysqli_free_result($result);
				} else {
					echo "<div>Error in the query: " . mysqli_error($con) . "</div>";
				}
			?>

            </div>
		</div>
		</div>
	</body>
</html>
